import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';

class HeartRateWidget extends StatelessWidget {
  const HeartRateWidget({super.key, required this.value});

  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.titleLarge?.copyWith(color: color);

    return Row(
      children: [
        _buildIcon(),
        const SizedBox(width: _tinyIndent),
        Text('$value', style: textStyle),
      ],
    );
  }

  Widget _buildIcon() => const SizedBox(
        height: lowIndent,
        width: lowIndent,
        child: LocalImage(assetPath: _iconPath),
      );
}

const _iconPath = 'assets/images/heart_rate_bold.svg';
const _tinyIndent = 4.0;
