import 'package:flutter/foundation.dart';

/// This state encapsulates view model of the [MainBottomBar].
class MainBottomBarState {
  /// Create a [MainBottomBarState] and initialize it with the given values.
  ///
  /// if [enabled] is true, the panel may process events.
  const MainBottomBarState({
    this.enabled = true,
    this.isAdvancedMode = false,
  });

  /// Indicates if the panel may process events.
  @protected
  final bool enabled;

  @protected
  final bool isAdvancedMode;

  /// Returns true if the panel may process events. Otherwise, it returns false.
  bool get isEnabled => enabled;

  bool get isDoctorMode => isAdvancedMode;

  /// Copy this state with the given fields replaced with the new values.
  ///
  /// if [enabled] is true, the panel may process events.
  MainBottomBarState copyWith({
    bool? enabled,
    bool? isAdvancedMode,
  }) =>
      MainBottomBarState(
        enabled: enabled ?? this.enabled,
        isAdvancedMode: isAdvancedMode ?? this.isAdvancedMode,
      );
}
