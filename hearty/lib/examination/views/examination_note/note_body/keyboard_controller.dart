import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final keyboardControllerProvider =
    StateNotifierProvider.autoDispose<KeyboardController, KeyboardState>(
  (_) => KeyboardController(),
);

class KeyboardController extends StateNotifier<KeyboardState> {
  KeyboardController() : super(const KeyboardState._());

  void specifyKeyboardVisibility() {
    final double bottomViewInsets = WidgetsBinding
        .instance.platformDispatcher.views.single.viewInsets.bottom;

    _updateState(bottomViewInsets);
  }

  void _updateState(double bottomViewInsets) => state = state.copyWith(
        statusState: bottomViewInsets > 0
            ? KeyboardStatusState.visible
            : KeyboardStatusState.invisible,
      );
}

enum KeyboardStatusState {
  visible,
  invisible,
}

class KeyboardState {
  final KeyboardStatusState statusState;

  const KeyboardState._({
    this.statusState = KeyboardStatusState.invisible,
  });

  KeyboardState copyWith({
    KeyboardStatusState? statusState,
  }) {
    return KeyboardState._(statusState: statusState ?? this.statusState);
  }
}
