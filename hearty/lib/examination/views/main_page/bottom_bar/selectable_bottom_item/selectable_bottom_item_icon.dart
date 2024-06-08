import 'package:flutter/material.dart';

/// This [StatelessWidget] encapsulates the view logic of an Icon of a
/// selectable bottom item.
///
/// To get color, it gets either
/// [BottomNavigationBarThemeData.selectedItemColor] or
/// [BottomNavigationBarThemeData.unselectedItemColor] depending on
/// the [SelectableBottomItemIcon.selected] value.
/// If the item color is undefined, it will take the [IconThemeData.color].
///
/// To get icon size and color, the widget gets either
/// [BottomNavigationBarThemeData.selectedIconTheme] or
/// [BottomNavigationBarThemeData.unselectedIconTheme] depending on
/// the [SelectableBottomItemIcon.selected] value.
/// They are optional but have a high priority.
/// A related [BottomNavigationBarTheme] overrides the default [IconTheme]
/// if it's defined.
class SelectableBottomItemIcon extends StatelessWidget {
  /// Creates an [Icon].
  ///
  /// The icon size are given by the current [IconTheme], and either
  /// [BottomNavigationBarThemeData.selectedIconTheme] or
  /// [BottomNavigationBarThemeData.unselectedIconTheme] depending on
  /// the given [selected] state.
  ///
  /// The icon color are given by the current [IconTheme], either
  /// [BottomNavigationBarThemeData.selectedIconTheme] or
  /// [BottomNavigationBarThemeData.unselectedIconTheme], and either
  /// [BottomNavigationBarThemeData.selectedItemColor] or
  /// [BottomNavigationBarThemeData.unselectedItemColor] depending on
  /// the given [selected] state.
  ///
  const SelectableBottomItemIcon({
    super.key,
    required this.icon,
    required this.selected,
  });

  /// The icon to display. The available icons are described in [Icons].
  final IconData icon;

  /// Whether to render the icon in the
  /// [BottomNavigationBarThemeData.selectedItemColor].
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = _findIconTheme(context);
    final color = _findIconColor(context);

    return IconTheme(
      data: iconTheme,
      child: Icon(icon, color: color),
    );
  }

  IconThemeData _findIconTheme(BuildContext context) {
    // We get either [BottomNavigationBarThemeData.selectedIconTheme] or
    // [BottomNavigationBarThemeData.unselectedIconTheme] depending on the
    // [selected] value.
    // They are optional but have a high priority. So a related
    // [BottomNavigationBarTheme] overrides the default [IconTheme]
    // if it's defined.
    final defaultIconTheme = IconTheme.of(context);
    final bottomBarTheme = BottomNavigationBarTheme.of(context);
    if (selected) {
      return defaultIconTheme.merge(bottomBarTheme.selectedIconTheme);
    }
    return defaultIconTheme.merge(bottomBarTheme.unselectedIconTheme);
  }

  Color? _findIconColor(BuildContext context) {
    // We get either [BottomNavigationBarThemeData.selectedItemColor] or
    // [BottomNavigationBarThemeData.unselectedItemColor] depending on the
    // [selected] value.
    final theme = BottomNavigationBarTheme.of(context);
    if (selected) {
      return theme.selectedItemColor;
    }
    return theme.unselectedItemColor;
  }
}
