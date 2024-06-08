import 'package:flutter/material.dart';

import '../../../../../../core/views.dart';

/// Defines a widget with an icon and the given [body] text next to it.
/// The icon and color of the text depend on a state.
class ValidationWidget extends StatelessWidget {
  /// Create a [ValidationWidget] with [isValid] state and [body] text.
  /// If [isValid] is true, the success icon will be shown,
  /// and the color of the text will be tropics.
  /// If [isValid] is false, the close icon will be shown,
  /// and the color of the text will be Durango blue.
  const ValidationWidget({
    super.key,
    this.isValid = false,
    required this.body,
  });

  final String body;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final validColor = theme.colorScheme.outlineVariant;
    final invalidColor = theme.colorScheme.onPrimaryContainer;
    final color = isValid ? validColor : invalidColor;

    final icon = _iconContainer(color);
    const horizontalIndent = SizedBox(width: _horizontalIndent);
    final text = Text(
      body,
      key: const Key('validation_text'),
      style: _textStyle(theme, color),
    );

    return Row(children: [icon, horizontalIndent, text]);
  }

  Widget _iconContainer(Color color) => Container(
        alignment: Alignment.center,
        child: _checkIcon(color),
      );

  Widget _checkIcon(Color color) => Icon(
        isValid ? AppIcons.check : AppIcons.close,
        key: const Key('validation_icon'),
        size: lowIndent,
        color: color,
      );

  TextStyle? _textStyle(ThemeData theme, Color color) =>
      theme.textTheme.bodyLarge?.copyWith(
        fontSize: belowLowIndent,
        color: color,
      );
}

const _horizontalIndent = 4.0;
