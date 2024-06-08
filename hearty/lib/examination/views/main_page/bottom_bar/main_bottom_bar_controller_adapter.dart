import 'package:auto_route/auto_route.dart';

import '../../../../auth/account/auth_profile_service.dart';
import '../../../../auth/account/user_role.dart';
import '../../../../core/core.dart';
import '../../../../utils/mixins/subscription_manager.dart';
import 'main_bottom_bar_controller.dart';

/// Implements the [MainBottomBarController].
class MainBottomBarControllerAdapter extends MainBottomBarController
    with SubscriptionManager {
  /// Creates a new [MainBottomBarControllerAdapter].
  MainBottomBarControllerAdapter(
    super.state, {
    required this.router,
    required this.examinationRoute,
    required this.authProfileService,
    required this.showStethoscope,
  }) {
    final subscription = authProfileService
        .observeProfileChanges()
        .map((event) => event?.role)
        .distinct()
        .listen(_listenRole);
    addSubscription(subscription);
  }

  /// The router to navigate between pages.
  final StackRouter router;

  /// A route to a page that creates a new examination.
  final PageRouteInfo examinationRoute;

  final AuthProfileService authProfileService;

  /// A command to show the stethoscope bottom sheet.
  final AsyncCommand showStethoscope;

  void _listenRole(UserRole? event) {
    state = state.copyWith(isAdvancedMode: event == UserRole.doctor);
  }

  @override
  void handleNewExaminationItemSelection() {
    assert(state.isEnabled, 'Event handling is disabled');
    state = state.copyWith(enabled: false);
    _handleNewExaminationItemSelection();
  }

  /// Asynchronously handle a selection event for the New Examination item.
  Future<void> _handleNewExaminationItemSelection() async {
    await router.push(examinationRoute);
    state = state.copyWith(enabled: true);
  }

  @override
  void handleStethoscopeItemSelection() {
    assert(state.isEnabled, 'Event handling is disabled');
    state = state.copyWith(enabled: false);
    _handleStethoscopeItemSelection();
  }

  /// Asynchronously handle a selection event for the Stethoscope item.
  Future<void> _handleStethoscopeItemSelection() async {
    await showStethoscope.execute();
    state = state.copyWith(enabled: true);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }
}
