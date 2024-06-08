import 'package:flutter/material.dart';

import 'constants.dart';

const _borderRadius = BorderRadius.all(Radius.circular(50.0));

class SegmentationPanelPathologicLabel extends StatelessWidget {
  const SegmentationPanelPathologicLabel({
    super.key,
    required this.label,
    this.color,
    required this.start,
    required this.end,
  });

  final String label;
  final Color? color;
  final double start;
  final double end;

  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: segmentationPanelHeight,
      width: segmentationPanelHeight,
      alignment: Alignment.center,
      decoration: _buildDecoration(context),
      child: _buildText(context),
    );
    return Container(
      width: end - start,
      alignment: Alignment.center,
      child: container,
    );
  }

  Decoration _buildDecoration(BuildContext context) => BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.error),
        borderRadius: _borderRadius,
        color: color,
      );

  Widget _buildText(BuildContext context) {
    final text = Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(color: Theme.of(context).colorScheme.onError),
    );
    return FittedBox(fit: BoxFit.scaleDown, child: text);
  }
}
