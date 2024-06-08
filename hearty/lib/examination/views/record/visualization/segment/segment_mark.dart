import 'package:flutter/material.dart';

abstract class SegmentMark extends StatelessWidget {
  const SegmentMark({
    super.key,
    required this.label,
    required this.start,
    required this.end,
    required this.height,
    this.gradient,
  })  : width = end - start,
        assert(end >= start);

  final String label;
  final double start;
  final double end;
  @protected
  final double width;
  final double height;
  final Gradient? gradient;

  @protected
  Decoration get decoration => BoxDecoration(gradient: gradient);
}
