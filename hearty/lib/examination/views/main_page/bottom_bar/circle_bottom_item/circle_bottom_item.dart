import 'package:flutter/material.dart';

import '../../../../../core/views.dart';

/// Encapsulate the view logic of a round bottom bar item with an icon.
///
/// The style of the item configures with the [CircleButtonTheme].
class CircleBottomItem extends StatelessWidget {
  /// Create a circle button with the given [radius] and [icon] at the center.
  CircleBottomItem({
    super.key,
    required this.icon,
    this.onPressed,
    this.radius,
  }) {
    final size = radius != null ? Size.fromRadius(radius!) : null;
    _style = ElevatedButton.styleFrom(fixedSize: size);
  }

  /// The icon of the item.
  final IconData icon;

  /// The radius of the circle item.
  final double? radius;

  /// The callback that is called when this item is tapped or otherwise
  /// activated.
  final void Function()? onPressed;

  late final ButtonStyle _style;

  @override
  Widget build(BuildContext context) {
    // Build a 3-layered widget.
    // The first layer is a background — the rear part of the item — filled
    // with a cyan-white gradient.
    // The second layer is a blue circle in front. It's smaller than the
    // background.
    // The other layer contains an icon aligned in the middle of the item.
    //
    // The closest [CircleButtonTheme] configures the appearance of the item.
    //
    // Item appearance should comply with the
    // [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18927).

    final theme = CircleButtonTheme.of(context);
    final content = Center(child: Icon(icon));
    final buttonForeground = Ink(decoration: theme.decoration, child: content);

    final foregroundContainer = Container(
      padding: theme.padding,
      child: buttonForeground,
    );

    final buttonBackground = Ink(
      decoration: theme.backgroundDecoration,
      child: foregroundContainer,
    );

    final style = _style.merge(theme.style);
    return ElevatedButton(
      onPressed: onPressed,
      style: style,
      child: buttonBackground,
    );
  }
}
