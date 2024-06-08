import 'package:flutter/material.dart';

/// This [StatelessWidget] encapsulates the view logic of a label of a
/// selectable bottom item.
///
/// To get the label color, it gets either the current
/// [BottomNavigationBarThemeData.selectedItemColor] or
/// [BottomNavigationBarThemeData.unselectedItemColor] depending on the
/// [SelectableBottomItemLabel.selected] value.
///
/// If the color is undefined, it will use the default [TextStyle].
///
/// To get [TextStyle] for the label, it gets the current
/// [TextTheme.labelSmall], either
/// [BottomNavigationBarThemeData.selectedLabelStyle] or
/// [BottomNavigationBarThemeData.unselectedLabelStyle].
/// Then the class merges them with the determined color to get the final style.
///
/// Priorities from higher to lower:
/// - [BottomNavigationBarThemeData.selectedItemColor] and
/// [BottomNavigationBarThemeData.unselectedItemColor].
/// - [BottomNavigationBarThemeData.selectedLabelStyle] and
/// [BottomNavigationBarThemeData.unselectedItemColor].
/// - The current [TextTheme.labelSmall].
class SelectableBottomItemLabel extends StatelessWidget {
  /// Creates a text label.
  ///
  /// The label color is given by either the current
  /// [BottomNavigationBarThemeData.selectedItemColor] or
  /// [BottomNavigationBarThemeData.unselectedItemColor] depending on the given
  /// [selected] state.
  ///
  /// If the item color is undefined, the label color is given by the current
  /// label style.
  ///
  /// The label style is given by the current [TextTheme.labelSmall], and
  /// either [BottomNavigationBarThemeData.selectedLabelStyle] or
  /// [BottomNavigationBarThemeData.unselectedLabelStyle] depending on the
  /// given [selected] state.
  const SelectableBottomItemLabel({
    super.key,
    required this.label,
    required this.selected,
  });

  /// The text label of the bottom bar item.
  final String label;

  /// Whether to render the label in the
  /// [BottomNavigationBarThemeData.selectedItemColor].
  final bool selected;

  @override
  Widget build(BuildContext context) => Text(label, style: _findStyle(context));

  TextStyle? _findStyle(BuildContext context) {
    // We get the [TextTheme.labelSmall], select or unselected label style,
    // and selected and unselected item colors to merge all of them to get
    // the final style.
    // Priorities from higher to lower: item color, label style,
    // and the [TextTheme.labelSmall].
    final defaultLabelStyle = Theme.of(context).textTheme.labelSmall;
    final labelStyle = _findBottomBarLabelStyle(context);
    final itemStyle = _findItemStyle(context);

    final style = labelStyle?.merge(itemStyle) ?? itemStyle;
    return defaultLabelStyle?.merge(style) ?? style;
  }

  TextStyle? _findBottomBarLabelStyle(BuildContext context) {
    // We get either the current [BottomNavigationBarTheme.selectedLabelStyle]
    // or [BottomNavigationBarTheme.unselectedLabelStyle] depending on the
    // [selected] value.
    final theme = BottomNavigationBarTheme.of(context);
    return selected ? theme.selectedLabelStyle : theme.unselectedLabelStyle;
  }

  TextStyle? _findItemStyle(BuildContext context) {
    const debugLabel = 'SelectableBottomItemLabel';
    final theme = BottomNavigationBarTheme.of(context);

    // To set the label color, we override the [TextStyle] of the label.
    //
    // We get either the current [BottomNavigationBarTheme.selectedItemColor]
    // or [BottomNavigationBarTheme.unselectedItemColor] depending on the
    // [selected] value.
    //
    // If the color is undefined, we will use the default [TextStyle].
    // So we should not override the style of the [Text].
    late final Color? color;
    if (selected) {
      color = theme.selectedItemColor;
    } else {
      color = theme.unselectedItemColor;
    }

    if (color != null) {
      return TextStyle(debugLabel: debugLabel, color: color);
    }
    return null;
  }
}
