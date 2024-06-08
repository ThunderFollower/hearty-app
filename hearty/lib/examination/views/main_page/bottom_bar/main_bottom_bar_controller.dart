import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_bottom_bar_state.dart';

/// Deals with the events of the [MainBottomBar].
abstract class MainBottomBarController
    extends StateNotifier<MainBottomBarState> {
  MainBottomBarController(super.state);

  /// Handle a selection event for the New Examination item.
  void handleNewExaminationItemSelection();

  /// Handle a selection event for the Stethoscope item.
  void handleStethoscopeItemSelection();
}
