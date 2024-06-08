import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../menu/index.dart';
import 'bottom_bar/main_bottom_bar.dart';
import 'content/main_content.dart';
import 'main_page_controller_provider.dart';
import 'menu/side_menu_button.dart';
import 'theme/second_theme.dart';

/// Defines the size of the menu icon.
const _menuIconSize = 24.0;
const _menuIconVerticalPadding = 35.0;

/// Defines the width of the top bar leading item.
///
/// Menu icon is centered. It's size is 24px. Left and right padding are 35px.
const _leadingWidth = _menuIconVerticalPadding * 2 + _menuIconSize;

/// A page encapsulates the view logic of the
/// [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=12447%3A25204).
@RoutePage()
class MainPage extends ConsumerWidget {
  /// Creates the [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=12447%3A25204).
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mainPageControllerProvider);

    final appBar = AppBar(
      leadingWidth: _leadingWidth,
      leading: const SideMenuButton(key: _sideMenuKey),
    );

    final scaffold = AppScaffold(
      appBar: appBar,
      body: const MainContent(),
      bottomNavigationBar: const MainBottomBar(),
      drawer: const MainDrawer(),
      onDrawerChanged: (bool opened) => controller.handleDrawerChange(
        opened: opened,
      ),
    );

    return SecondTheme(child: scaffold);
  }
}

// Keys
const _sideMenuKey = Key('side_menu_key');
