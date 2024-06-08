import 'package:flutter/material.dart';

import 'segment_mark.dart';

class UnsegmentedMark extends SegmentMark {
  const UnsegmentedMark({
    super.key,
    required super.label,
    required super.start,
    required super.end,
    required super.height,
    super.gradient,
  });

  @override
  Widget build(BuildContext context) => wrap(
        Container(width: width, decoration: decoration),
      );

  Widget wrap(Widget widget) => Positioned(
        left: start,
        height: height,
        child: RepaintBoundary(child: widget),
      );
}
