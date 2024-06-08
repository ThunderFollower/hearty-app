import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../examination.dart';
import '../segment/segment.dart';
import 'pathologic_segment.dart';
import 'spectrogram_segment_mark.dart';

class SpectrogramSegment extends StatelessWidget {
  const SpectrogramSegment({
    super.key,
    required this.label,
    required this.start,
    required this.end,
    required this.height,
    this.frequency,
    required this.type,
    required this.frequencyRange,
  });

  final String label;
  final double start;
  final double end;
  final double height;
  final int? frequency;
  final SegmentTypes type;
  final RangeValues frequencyRange;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case SegmentTypes.s1:
        return buildSpectrogram();

      case SegmentTypes.s2:
        return buildSpectrogram();

      case SegmentTypes.s3:
      case SegmentTypes.s4:
        return buildPathologic(context);

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
        gradient: AppGradients.whiteTransparent,
      );

  Widget buildSpectrogram() => SpectrogramSegmentMark(
        key: Key(label),
        label: label,
        start: start,
        end: end,
        height: height,
      );

  Widget buildPathologic(BuildContext context) => PathologicSegmentMark(
        label: label,
        color: Theme.of(context).colorScheme.error,
        start: start,
        end: end,
        frequency: frequency ?? height.toInt(),
        height: height,
        frequencyRange: frequencyRange,
      );
}
