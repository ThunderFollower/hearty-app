import 'package:flutter/material.dart';

import '../theme/index.dart';

class ConfirmationDialog extends StatelessWidget {
  final String header;
  final String buttonLabel;
  final String description;
  final VoidCallback action;

  const ConfirmationDialog({
    super.key,
    required this.header,
    required this.buttonLabel,
    this.description = '',
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        _buildTitle(theme),
        const SizedBox(height: belowMediumIndent),
        if (description.isNotEmpty) ...[
          _buildDescription(theme),
          const SizedBox(height: middleIndent),
        ],
        _buildButton(theme),
      ],
    );
  }

  Widget _buildButton(ThemeData theme) {
    final color = theme.colorScheme.primaryContainer;
    final textStyle = theme.textTheme.labelLarge?.copyWith(color: color);
    final styleFrom = ElevatedButton.styleFrom(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: _buttonShape,
    );
    final text = Text(buttonLabel, style: textStyle);
    final elevatedButton = ElevatedButton(
      key: _confirmButtonKey,
      onPressed: action,
      style: styleFrom,
      child: text,
    );
    final decoratedBox = DecoratedBox(
      decoration: _decoration,
      child: elevatedButton,
    );

    return SizedBox(
      width: double.infinity,
      height: _buttonHeight,
      child: decoratedBox,
    );
  }

  Widget _buildDescription(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(description, textAlign: TextAlign.center, style: textStyle);
  }

  Widget _buildTitle(ThemeData theme) {
    final titleTextStyle = theme.textTheme.titleLarge;

    return Text(header, textAlign: TextAlign.center, style: titleTextStyle);
  }
}

const _borderRadius = BorderRadius.all(Radius.circular(belowHightIndent));
const _decoration = BoxDecoration(
  gradient: AppGradients.red,
  borderRadius: _borderRadius,
);
const _buttonShape = RoundedRectangleBorder(borderRadius: _borderRadius);
const _buttonHeight = 56.0;
const _confirmButtonKey = Key('confirm_button_key');
