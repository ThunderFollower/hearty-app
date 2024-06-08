import 'package:flutter/material.dart';

import '../segment/segment.dart';

class OscillogramSegmentMark extends SegmentMark {
  const OscillogramSegmentMark({
    super.key,
    required super.label,
    required super.start,
    required super.end,
    required super.height,
    super.gradient,
  });

  @override
  Widget build(BuildContext context) => wrap(
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(gradient: gradient),
        ),
      );

  Widget wrap(Widget widget) => Positioned(
        left: start,
        child: RepaintBoundary(child: widget),
      );
}
