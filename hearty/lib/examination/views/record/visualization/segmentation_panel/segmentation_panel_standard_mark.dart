import 'package:flutter/material.dart';

class SegmentationPanelStandardMark extends StatelessWidget {
  const SegmentationPanelStandardMark({
    super.key,
    required this.label,
    required this.gradient,
    required this.start,
    required this.end,
  });

  final String label;
  final LinearGradient gradient;
  final double start;
  final double end;

  @override
  Widget build(BuildContext context) => Container(
        width: end - start,
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: gradient),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(label, textAlign: TextAlign.center),
        ),
      );
}
