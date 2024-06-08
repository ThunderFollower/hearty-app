import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_router.gr.dart';
import '../../../../auth/auth.dart';
import '../../../../core/core.dart';
import '../../../../core/views.dart';
import 'main_bottom_bar_controller.dart';
import 'main_bottom_bar_controller_adapter.dart';
import 'main_bottom_bar_state.dart';

/// Defines a provider for [MainBottomBarState].
final mainBottomBarStateProvider = StateNotifierProvider.autoDispose<
    MainBottomBarController, MainBottomBarState>(
  (ref) {
    final router = ref.watch(routerProvider);
    final authProfileService = ref.watch(authProfileServiceProvider);
    return MainBottomBarControllerAdapter(
      const MainBottomBarState(),
      router: router,
      examinationRoute: ExaminationRoute(),
      authProfileService: authProfileService,
      showStethoscope: ref.watch(showStethoscopeProvider),
    );
  },
);
