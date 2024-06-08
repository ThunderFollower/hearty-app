import 'package:flutter/material.dart';

import '../segment/segment.dart';

part 'spectrogram_segment_mark_painter.dart';

class SpectrogramSegmentMark extends SegmentMark {
  const SpectrogramSegmentMark({
    super.key,
    required super.label,
    required super.start,
    required super.end,
    required super.height,
  });

  @override
  Widget build(BuildContext context) => wrap(
        CustomPaint(
          foregroundPainter: _Painter(Theme.of(context).colorScheme.shadow),
          child: SizedBox(width: width, height: double.infinity),
        ),
      );

  Widget wrap(Widget widget) => Positioned(
        left: start,
        height: height,
        child: RepaintBoundary(child: widget),
      );
}
