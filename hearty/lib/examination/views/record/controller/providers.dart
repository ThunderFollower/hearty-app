import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:logger/logger.dart';

import '../../../../../../../auth/auth.dart';
import '../../../../../../../core/core.dart';
import '../../../../../../../core/views.dart';
import '../../../../../../../utils/utils.dart';
import '../../../cardio_findings/cardio_findings.dart';
import '../../../examination.dart';
import 'playing_speed.dart';
import 'record_controller.dart';
import 'record_controller_impl.dart';
import 'record_state.dart';

final recordStateProvider = StateNotifierProvider.family
    .autoDispose<RecordController, RecordState, String>(
  (ref, recordId) {
    // The controller will have a minimal grace period of 100 milliseconds,
    // during which it can be reused before it's disposed, ensuring that
    // settings are reset when re-opening the record screen.
    ref.delayDispose(const Duration(milliseconds: 100));

    final state = RecordState(
      isSpectrogramMode: true,
      speed: PlayingSpeed.x1.value,
    );

    final showStethoscope = ref.watch(showStethoscopeProvider);
    return RecordControllerImpl(
      state,
      recordId: recordId,
      router: ref.watch(routerProvider),
      recordService: ref.watch(recordServiceProvider),
      segmentService: ref.watch(segmentServiceProvider),
      showErrorNotification: ref.watch(showErrorNotificationProvider),
      logger: Logger(),
      cardioFindingService: ref.watch(cardioFindingServiceProvider),
      assetService: ref.watch(assetServiceProvider),
      audioEngine: ref.watch(audioEngineProvider),
      authProfileService: ref.watch(authProfileServiceProvider),
      player: ref.watch(flutterSoundPlayerProvider),
      spectrogramGenerator: ref.watch(spectrogramGeneratorProvider),
      showStethoscope: showStethoscope as ShowStethoscopeUseCase,
      deleteRecord: ref.watch(deleteRecordProvider),
    );
  },
);

final flutterSoundPlayerProvider = Provider.autoDispose<FlutterSoundPlayer>(
  (ref) {
    const logLevel = kDebugMode ? Level.info : Level.warning;
    final player = FlutterSoundPlayer(logLevel: logLevel);

    player
        .openAudioSession(
      device: AudioDevice.blueToothA2DP,
      audioFlags: allowHeadset |
          allowEarPiece |
          allowBlueToothA2DP |
          outputToSpeaker |
          allowAirPlay,
    )
        .catchError((error) {
      Logger().e(error);
      return null;
    });

    ref.onDispose(player.closeAudioSession);
    return player;
  },
);
