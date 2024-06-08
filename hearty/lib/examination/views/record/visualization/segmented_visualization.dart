import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/views.dart';
import 'central_mark/central_mark.dart';
import 'items/finding_label_widget.dart';
import 'items/heart_rate_widget.dart';
import 'mode_switcher/visualization_mode_switcher.dart';
import 'oscillogram/segmented_oscillogram.dart';
import 'ruler/chrono_ruler.dart';
import 'segment/segment_state.dart';
import 'segmentation_panel/segmentation_panel.dart';
import 'spectrogram/segmented_spectrogram.dart';

part 'segmented_visualization_body.dart';
part 'segmented_visualization_cardio.dart';
part 'segmented_visualization_panel_layout.dart';
part 'segmented_visualization_surface.dart';

const double _extraSectionsPadding = 50;
const _segmentationPanelSpacerHeight = 6.0;

class SegmentedVisualization extends StatelessWidget {
  const SegmentedVisualization({
    super.key,
    this.segments,
    this.hasMurmur,
    this.heartRate,
    this.isFine,
    this.oscillogramData,
    this.spectrogramData,
    this.isSpectrogramMode,
    this.onChangeMode,
    this.recordId,
    this.duration,
    this.scale,
    this.onScaleStart,
    this.onScaleUpdate,
    this.onScaleEnd,
    this.onHorizontalDragDown,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
  });

  final Iterable<SegmentState>? segments;

  /// Indicates if the record has a murmur.
  final bool? hasMurmur;

  /// The heart rate associated with this record.
  final int? heartRate;

  /// Indicates if the record is fine.
  final bool? isFine;

  /// The oscillogram data for this record.
  final Iterable<double>? oscillogramData;

  /// The spectrogram image data for this record.
  final ui.Image? spectrogramData;

  /// Indicates if the spectrogram mode is active.
  final bool? isSpectrogramMode;

  final VoidCallback? onChangeMode;

  /// Identifier for the associated audio record.
  final String? recordId;

  /// Represents the total duration of the audio.
  final Duration? duration;

  final double? scale;

  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;

  @override
  Widget build(BuildContext context) {
    final id = recordId;
    if (id == null || _isInvalidData()) {
      return const Loader();
    }

    return _Body(
      isSpectrogramMode: isSpectrogramMode,
      segments: segments,
      image: spectrogramData,
      dataSet: oscillogramData,
      isFine: isFine,
      hasMurmur: hasMurmur,
      heartRate: heartRate,
      onChangeMode: () {},
      recordId: id,
      duration: duration ?? Duration.zero,
      scale: scale ?? 1.0,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
    );
  }

  bool _isInvalidData() =>
      duration == null ||
      scale == null ||
      isSpectrogramMode == null ||
      isSpectrogramMode == false && oscillogramData == null ||
      isSpectrogramMode == true && spectrogramData == null;
}
