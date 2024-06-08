import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../locator/app_locator.dart';
import '../theme/app_icons.dart';
import 'title_bar_controller_provider.dart';

/// Defines a Title Bar Item for the back action.
class CloseTitleBarItem extends ConsumerWidget {
  const CloseTitleBarItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Return a back button if navigating back is possible.
    final controller = ref.watch(titleBarControllerProvider);
    if (controller.canNavigateBack) {
      return IconButton(
        key: _backButtonKey,
        icon: const AppLocator(
          id: 'close_button',
          child: Icon(AppIcons.close),
        ),
        onPressed: controller.navigateBack,
      );
    }
    return Container();
  }
}

// Keys
const _backButtonKey = Key('close_button_key');
