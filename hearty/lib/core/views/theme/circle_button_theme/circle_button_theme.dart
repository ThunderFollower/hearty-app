import 'package:flutter/material.dart';

import 'circle_button_theme_data.dart';

/// Overrides the default style of its circle button descendants.
class CircleButtonTheme extends InheritedWidget {
  /// Creates a [CircleButtonTheme] with the given [data].
  const CircleButtonTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// The configuration of this theme.
  final CircleButtonThemeData data;

  /// Returns [data] of the closest instance of this class that encloses the
  /// given context.
  ///
  /// If there is no enclosing [CircleButtonTheme] widget, then a default
  /// data is used.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// CircleButtonThemeData theme = CircleButtonTheme.of(context);
  /// ```
  static CircleButtonThemeData of(BuildContext context) {
    final widget =
        context.dependOnInheritedWidgetOfExactType<CircleButtonTheme>();
    return widget?.data ?? CircleButtonThemeData();
  }

  @override
  bool updateShouldNotify(CircleButtonTheme oldWidget) {
    return data != oldWidget.data;
  }
}
