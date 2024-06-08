import 'package:flutter/material.dart';

import 'constants.dart';

const _borderRadius = BorderRadius.all(Radius.circular(50.0));

class SegmentationPanelPathologicMark extends StatelessWidget {
  const SegmentationPanelPathologicMark({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        height: segmentationPanelHeight,
        width: segmentationPanelHeight,
        alignment: Alignment.center,
        decoration: _buildDecoration(context),
        child: _buildText(),
      );

  Decoration _buildDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.error),
        borderRadius: _borderRadius,
        color: color,
      );

  Widget _buildText() => FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label, textAlign: TextAlign.center),
      );
}
