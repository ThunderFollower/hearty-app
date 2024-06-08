import 'package:flutter/material.dart';

const _defaultHeight = 112.0;
const _defaultPadding = EdgeInsets.symmetric(horizontal: 24.0);

/// The application bottom bar encapsulates the view logic accordingly to the
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18927).
///
/// It uses [ColorScheme.outline] to configure the color of the top border.
///
/// [ColorScheme.primaryContainer] configures the color of the bar itself.
class BottomBar extends StatelessWidget {
  /// Creates a panel with the given list of [items].
  ///
  /// The [ColorScheme.outline] and [ColorScheme.primaryContainer] customize
  /// the colors of the panel.
  const BottomBar({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.height,
    this.padding,
    required this.items,
  });

  /// The height value includes the [padding].
  ///
  /// If null, the default height is used. The default is 112px.
  final double? height;

  /// A space between a widget's border and the widget's [items].
  ///
  /// If the value is null, left and right paddings will be 24px by default.
  final EdgeInsetsGeometry? padding;

  /// Defines how it should place the [items] along the Main axis.
  ///
  /// For example, [MainAxisAlignment.start] places the children at the
  /// beginning of the Main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// A list of children of this bar.
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    // [ColorScheme.outline] configures the color of a divider between
    // the page content and this panel.
    // [ColorScheme.primaryContainer] configures the color of
    // the background color.
    final colorScheme = Theme.of(context).colorScheme;
    final side = BorderSide(color: colorScheme.outline);
    final decoration = BoxDecoration(
      border: Border(top: side),
      color: colorScheme.primaryContainer,
    );

    final row = Row(
      mainAxisAlignment: mainAxisAlignment,
      children: items,
    );

    return Container(
      height: height ?? _defaultHeight,
      padding: padding ?? _defaultPadding,
      decoration: decoration,
      child: row,
    );
  }
}
