import 'package:flutter/material.dart';

/// Encapsulates view logic related to the material theme based on
/// the secondary color.
class SecondTheme extends StatelessWidget {
  /// Applies a theme based on the secondary color for
  /// [Scaffold] and [AppBar] backgrounds.
  const SecondTheme({super.key, required this.child});

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.background;

    final appBarTheme = theme.appBarTheme.copyWith(
      backgroundColor: backgroundColor,
    );
    final activeTheme = theme.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: appBarTheme,
    );

    return Theme(
      data: activeTheme,
      child: child,
    );
  }
}
