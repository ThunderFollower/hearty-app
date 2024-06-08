import 'package:flutter/material.dart';

/// Defines a theme widget based on the primary container color.
class PrimaryContainerTheme extends StatelessWidget {
  /// Apply a theme based on the primary container color to the given [child].
  const PrimaryContainerTheme({
    super.key,
    required this.child,
  });

  /// The widget below this widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primaryContainer;
    final appBarTheme = theme.appBarTheme.copyWith(color: backgroundColor);
    final data = theme.copyWith(appBarTheme: appBarTheme);

    return Theme(data: data, child: child);
  }
}
