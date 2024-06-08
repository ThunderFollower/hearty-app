import 'package:flutter/material.dart';

/// A custom [TextButton] widget that can be reused throughout the app.
///
/// This button applies certain styles to the text and handles its overflow.
class AppTextButton extends StatelessWidget {
  /// Creates an [AppTextButton] that displays [child] widget.
  ///
  /// If [onPressed] is null, the button will be disabled.
  /// Otherwise, it's called when the button is tapped.
  const AppTextButton({
    this.onPressed,
    required this.child,
    super.key,
  });

  /// The callback that is called when the button is tapped.
  ///
  /// If this is null, the button will be disabled.
  final VoidCallback? onPressed;

  /// The widget to display as the button's child.
  ///
  /// Typically a [Text] widget, but can be any widget that fits within the button.
  final Widget child;

  @override
  Widget build(BuildContext context) => TextButtonTheme(
        data: _buildTextButtonThemeData(context),
        child: TextButton(onPressed: onPressed, child: child),
      );

  /// Builds the ThemeData for the TextButton.
  ///
  /// Merges the app's current theme with specific styles for this button.
  TextButtonThemeData _buildTextButtonThemeData(BuildContext context) {
    final theme = Theme.of(context);

    final bodyMedium = theme.textTheme.bodyMedium;
    final textStyle = bodyMedium?.copyWith(overflow: TextOverflow.ellipsis);
    final style = TextButton.styleFrom(
      foregroundColor: theme.colorScheme.secondaryContainer,
      disabledForegroundColor: theme.colorScheme.secondary,
      textStyle: textStyle,
    ).merge(theme.textButtonTheme.style);

    return TextButtonThemeData(style: style);
  }
}
