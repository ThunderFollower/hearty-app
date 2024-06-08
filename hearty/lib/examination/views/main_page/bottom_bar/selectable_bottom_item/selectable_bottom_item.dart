import 'package:flutter/material.dart';

import 'selectable_bottom_item_icon.dart';
import 'selectable_bottom_item_label.dart';

/// Encapsulate the view logic of a [MainBottomBar] item with an icon and title.
/// The style of the item can be configured with [BottomNavigationBarTheme].
class SelectableBottomItem extends StatelessWidget {
  /// Creates an item that is used with [MainBottomBar].
  const SelectableBottomItem({
    super.key,
    required this.icon,
    this.onTap,
    this.selected = false,
    this.label,
    this.width = 88.0,
    this.height = 46.0,
  });

  /// The callback that is called when this item is tapped.
  final void Function()? onTap;

  /// The icon of the item.
  final IconData icon;

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
    final column = Column(
      children: [
        SelectableBottomItemIcon(icon: icon, selected: selected),
        const Spacer(),
        if (label != null && _isLabelShown(context))
          SelectableBottomItemLabel(label: label!, selected: selected),
      ],
    );

    final hitBox = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: column,
    );

    return SizedBox(
      width: width,
      height: height,
      child: hitBox,
    );
  }

  /// Returns true if the label is visible for the current [selected] value.
  ///
  /// Visibility state of the label is determined with the
  /// [BottomNavigationBarTheme].
  bool _isLabelShown(BuildContext context) {
    final theme = BottomNavigationBarTheme.of(context);
    if (selected) {
      return theme.showSelectedLabels ?? true;
    }
    return theme.showUnselectedLabels ?? true;
  }
}
