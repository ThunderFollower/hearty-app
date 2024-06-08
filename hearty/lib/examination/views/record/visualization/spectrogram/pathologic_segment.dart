import 'package:flutter/material.dart';

import '../segment/segment.dart';

class PathologicSegmentMark extends SegmentMark {
  const PathologicSegmentMark({
    super.key,
    required super.label,
    required super.start,
    required super.end,
    required super.height,
    required this.color,
    required this.frequency,
    required this.frequencyRange,
  });

  final Color color;
  final int frequency;
  final RangeValues frequencyRange;

  @protected
  double get highestFrequency => frequencyRange.end;

  @protected
  double get lowestFrequency => frequencyRange.start;

  @override
  Decoration get decoration => BoxDecoration(
        border: Border.all(color: color, width: 3.0),
      );

  @override
  Widget build(BuildContext context) => wrap(
        Container(
          width: width,
          height: double.infinity,
          decoration: decoration,
        ),
      );

  Widget wrap(Widget widget) {
    final top = windowSize;
    return Positioned(
      left: start,
      height: top,
      top: height - top,
      child: RepaintBoundary(child: widget),
    );
  }

  @protected
  double get windowSize {
    final step = height / (highestFrequency - lowestFrequency);
    final normalizedFrequency =
        (frequency - lowestFrequency) > 0 ? frequency - lowestFrequency : 0;
    return normalizedFrequency * step;
  }
}
