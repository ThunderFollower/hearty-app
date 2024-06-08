import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/views.dart';
import '../common/common.dart';
import '../record_error/record_error.dart';
import '../segment/segment.dart';
import 'ruler/frequency_ruler.dart';
import 'spectrogram_segment.dart';

part 'segmented_spectrogram_state.dart';

class SegmentedSpectrogram extends VisualizationWidget {
  const SegmentedSpectrogram({
    super.key,
    required super.width,
    required super.recordId,
    required super.duration,
    required this.spectrogramImage,
    required this.margin,
    required this.scale,
    this.segments,
  });

  final ui.Image spectrogramImage;
  final EdgeInsets margin;
  final double scale;
  final Iterable<SegmentState>? segments;

  @override
  ConsumerState<SegmentedSpectrogram> createState() =>
      _SegmentedSpectrogramState();
}
