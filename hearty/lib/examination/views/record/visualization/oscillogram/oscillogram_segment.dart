import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../examination.dart';
import '../segment/segment.dart';
import 'oscillogram_segment_mark.dart';

class OscillogramSegment extends StatelessWidget {
  const OscillogramSegment({
    super.key,
    required this.label,
    required this.start,
    required this.end,
    required this.height,
    required this.type,
  });

  final String label;
  final double start;
  final double end;
  final double height;
  final SegmentTypes type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SegmentTypes.s1:
        return buildOscillogram(AppGradients.cyan2);

      case SegmentTypes.s2:
        return buildOscillogram(AppGradients.orange);

      case SegmentTypes.s3:
      case SegmentTypes.s4:
        return const SizedBox.shrink();

      case SegmentTypes.unsegmentable:
        break;
    }

    return buildUnsegmentable();
  }

  @protected
  Widget buildUnsegmentable() => UnsegmentedMark(
        label: label,
        start: start,
        end: end,
        height: height,
        gradient: AppGradients.blueTransparent,
      );

  @protected
  Widget buildOscillogram(Gradient gradient) => OscillogramSegmentMark(
        key: Key(label),
        label: label,
        start: start,
        end: end,
        height: height,
        gradient: gradient,
      );
}
