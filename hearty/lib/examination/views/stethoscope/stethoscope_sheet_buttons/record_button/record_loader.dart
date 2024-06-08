import 'package:flutter/material.dart';

class RecordLoader extends StatelessWidget {
  const RecordLoader({
    required this.size,
    required this.strokeWidth,
  });

  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.error;
    final backgroundColor = theme.colorScheme.background;

    final circularProgressIndicator = CircularProgressIndicator(
      strokeWidth: strokeWidth,
      color: color,
      backgroundColor: backgroundColor,
    );

    return SizedBox.square(
      dimension: size,
      child: circularProgressIndicator,
    );
  }
}
