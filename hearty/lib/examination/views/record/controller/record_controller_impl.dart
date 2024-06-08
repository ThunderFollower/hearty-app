import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../auth/auth.dart';
import '../../../../../../../config.dart';
import '../../../../../../../core/core.dart';
import '../../../../../../../core/views.dart';
import '../../../../../../../utils/utils.dart';
import '../../../cardio_findings/cardio_findings.dart';
import '../../../examination.dart';
import '../playback_controls/filters_extension.dart';
import '../report/controller/record_report_controller_impl.dart';
import '../visualization/segment/segment.dart';
import 'playing_speed.dart';
import 'record_controller.dart';
import 'record_state.dart';

part 'record_controller_impl_base.dart';
part 'record_controller_impl_cardio.dart';
part 'record_controller_impl_player.dart';
part 'record_controller_impl_record.dart';
part 'record_controller_impl_segments.dart';
part 'record_controller_impl_user.dart';

class RecordControllerImpl extends _Base
    with _Player, _Record, _Cardio, _Segments, _User {
  RecordControllerImpl(
    super.state, {
    required super.recordId,
    required super.router,
    required super.recordService,
    required super.segmentService,
    required super.logger,
    required super.showErrorNotification,
    required super.cardioFindingService,
    required super.assetService,
    required super.audioEngine,
    required super.authProfileService,
    required super.player,
    required super.spectrogramGenerator,
    required super.showStethoscope,
    required super.deleteRecord,
  }) {
    _initPlayer();
    _loadRecord();
    _loadCardioFindings();
    _loadSegments();
    _loadUser();
  }

  /// The horizontal size of the visualization window.
  static const visualizationSize = int.fromEnvironment(
    'VISUALIZATION_SIZE',
    defaultValue: 2000,
  );

  /// The minimum value of zoom.
  static const minScale = 1.0 /
      int.fromEnvironment(
        'VISUALIZATION_MIN_ZOOM_FRACTION',
        defaultValue: 1,
      );

  /// The maximum value of zoom.
  static const maxScale = 1.0 *
      int.fromEnvironment(
        'VISUALIZATION_MAX_ZOOM',
        defaultValue: 10,
      );

  @override
  void dispose() {
    cancelSubscriptions();
    logger.close();
    filterSubject.close();
    _disposePlayer();
    super.dispose();
  }

  @override
  void dismiss() {
    player.stopPlayer();

    final currentPath = resolveRecordUri(recordId).path;
    router.popUntilRouteWithPath(currentPath);
    if (router.canPop() && router.currentPath == currentPath) {
      router.pop();
    }
  }

  @override
  void setFilter(Filters filter) {
    if (state.filter == filter) return;
    // Stop the audio playback just in case
    _stop();

    state = state.copyWith(filter: filter);
    filterSubject.add(filter);
  }

  @override
  void toggleMode() {
    state = state.copyWith(isSpectrogramMode: state.isSpectrogramMode == false);
  }

  @override
  void togglePlaying() {
    if (state.isPlaying == true) {
      _pause();
    } else if (state.audioUri != null) {
      _playOrResume();
    }
  }

  @override
  Future<void> toggleSpeed() async {
    if (state.isEnabled == false) return;
    state = state.copyWith(isEnabled: false);

    var speed = state.speed ?? PlayingSpeed.x1.value;
    if (speed <= PlayingSpeed.x025.value) {
      speed = PlayingSpeed.x1.value;
    } else if (speed <= PlayingSpeed.x05.value) {
      speed = PlayingSpeed.x025.value;
    } else if (speed <= PlayingSpeed.x1.value) {
      speed = PlayingSpeed.x05.value;
    }

    final isPlaying = state.isPlaying;

    if (isPlaying == true) await _stop();
    await player.setSpeed(speed);
    state = state.copyWith(speed: speed);
    if (isPlaying == true) await _play();
    state = state.copyWith(isEnabled: true);
  }

  @override
  void onScaleStart(ScaleStartDetails event) {
    state = state.copyWith(scaleStart: state.scale, isScaling: true);
    if (player.isPlaying) {
      player.pausePlayer();
    }
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails event) {
    final scaleStart = state.scaleStart;
    if (scaleStart == null) return;
    final scale = scaleStart * event.horizontalScale;
    state = state.copyWith(scale: _normalizeScale(scale));
  }

  @override
  Future<void> onScaleEnd(ScaleEndDetails _) async {
    if (state.isEnabled == false) return;
    state = state.copyWith(isEnabled: false);

    if (state.isPlaying == true) await _resume();

    var scale = state.scale;
    if (scale != null) scale = _normalizeScale(scale);
    state = state.copyWith(
      scale: scale,
      isScaling: false,
      isEnabled: true,
    );
  }

  double _normalizeScale(double scale) => max(minScale, min(maxScale, scale));

  @override
  void onHorizontalDragDown(DragDownDetails _) {
    if (state.isPlaying == true) {
      _stopAnimation();
      player.pausePlayer();
      state = state.copyWith(isPlaying: true);
    }
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails event) {
    final delta = event.primaryDelta;
    final scale = state.scale;
    final duration = state.duration?.inMicroseconds;
    final position = state.position?.inMicroseconds;
    if (delta == null ||
        scale == null ||
        duration == null ||
        duration == 0 ||
        position == null) {
      return;
    }

    final width = visualizationSize * scale;
    final ratio = duration / width;

    var microseconds = position - (delta * ratio).toInt();
    microseconds = min(microseconds, duration);
    state = state.copyWith(position: Duration(microseconds: microseconds));
  }

  @override
  void onHorizontalDragEnd(DragEndDetails _) {
    onHorizontalDragCancel();
  }

  @override
  Future<void> onHorizontalDragCancel() async {
    if (state.isEnabled == false) return;
    state = state.copyWith(isEnabled: false);

    if (state.isPlaying == true && state.isScaling != true) {
      await _resume();
    }

    state = state.copyWith(isEnabled: true);
  }

  @override
  Future<void> delete() async {
    try {
      await deleteRecord.execute(recordId, cancellation);
      dismiss();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  @override
  Future<void> recordAgain() async {
    try {
      await _disposePlayer();
      await player.closeAudioSession();
      state = state.copyWith(isPlaying: false);
      await showStethoscope.execute(
        mode: StethoscopeMode.recording,
        recordId: recordId,
      );
      state = state.copyWith(position: Duration.zero);
      await _openAudioSession();
      _initPlayer();
    } on PlatformException catch (error, stackTrace) {
      _handlePlatformException(error, stackTrace);
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  void _handlePlatformException(
    PlatformException error,
    StackTrace stackTrace,
  ) {
    if (error.code == _audioError && error.message == _sessionFailure) {
      router.pop();
    } else {
      _handleError(error, stackTrace);
    }
  }
}

const _audioError = 'Audio Player';
const _sessionFailure = 'Open session failure';
