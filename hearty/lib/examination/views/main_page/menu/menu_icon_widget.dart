import 'package:flutter/material.dart';

import '../../../../core/views.dart';

const _locatorIdentifier = 'side_menu_btn';

/// Encapsulate the view logic of the menu icon.
class MenuIconWidget extends StatelessWidget {
  /// Creates a menu icon.
  const MenuIconWidget({super.key});

  @override
  Widget build(BuildContext context) => const AppLocator(
        id: _locatorIdentifier,
        child: Icon(AppIcons.menu),
      );
}
