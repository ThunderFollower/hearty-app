import 'package:flutter/material.dart';

class SegmentationPanelCommonLabel extends StatelessWidget {
  const SegmentationPanelCommonLabel({
    super.key,
    required this.label,
    this.gradient,
    required this.start,
    required this.end,
  });

  final String label;
  final Gradient? gradient;
  final double start;
  final double end;

  @override
  Widget build(BuildContext context) {
    final text = Text(label, textAlign: TextAlign.center);
    return Container(
      width: end - start,
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: gradient),
      child: FittedBox(fit: BoxFit.scaleDown, child: text),
    );
  }
}
