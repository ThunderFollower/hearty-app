import 'package:flutter/material.dart';

import 'menu_icon_widget.dart';

/// Encapsulate the view logic of the side menu button.
///
/// Clicking on the button will open the [Drawer] (if any).
class SideMenuButton extends StatelessWidget {
  /// Creates a new side menu button.
  ///
  /// Clicking on the button will open the [Drawer] (if any).
  const SideMenuButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: Scaffold.of(context).openDrawer,
        padding: EdgeInsets.zero,
        icon: const MenuIconWidget(),
      );
}
