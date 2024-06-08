import 'package:flutter/material.dart';

import '../../../../../core/views/local_image/local_image.dart';

class BottomBarButton extends StatelessWidget {
  const BottomBarButton({
    super.key,
    required this.assetPath,
    this.onTap,
    this.selected = false,
    this.label,
    this.width = 88.0,
    this.height = 46.0,
  });

  /// The callback that is called when this item is tapped.
  final void Function()? onTap;

  final String assetPath;

  /// The text label for this item.
  final String? label;

  /// Whether to render icons and label in the
  /// [BottomNavigationBarThemeData.selectedItemColor].
  final bool selected;

  /// If non-null, this is the precise width of this item.
  final double? width;

  /// If non-null, this is the precise height of this item.
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final column = Column(
      children: [
        LocalImage(assetPath: assetPath, color: Colors.pink),
        const Spacer(),
        if (label != null) _buildLabel(theme, label!),
      ],
    );

    final hitBox = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: column,
    );

    return SizedBox(width: width, height: height, child: hitBox);
  }

  Widget _buildLabel(ThemeData theme, String text) {
    final color = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.labelSmall?.copyWith(color: color);

    return Text(text, style: textStyle);
  }
}
