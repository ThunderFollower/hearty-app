import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../core/views.dart';

import '../common/common.dart';
import '../record_error/record_error.dart';
import '../segment/segment.dart';
import '../segmentation_panel/constants.dart';
import 'oscillogram_painter.dart';
import 'oscillogram_segment.dart';

part 'segmented_oscillogram_state.dart';

class SegmentedOscillogram extends VisualizationWidget {
  const SegmentedOscillogram({
    super.key,
    required super.width,
    required super.recordId,
    required super.duration,
    required this.dataSet,
    required this.extraSectionsPadding,
    this.lineWidth = 2.0,
    this.margin = const EdgeInsets.all(10.0),
    this.segments,
  });

  final Iterable<double> dataSet;
  final EdgeInsetsGeometry margin;
  final double lineWidth;
  final double extraSectionsPadding;
  final Iterable<SegmentState>? segments;

  @override
  ConsumerState<SegmentedOscillogram> createState() =>
      _SegmentedOscillogramState();
}
