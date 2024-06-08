import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config.dart';
import 'constants.dart';
import 'password_validation_state.dart';

/// Defines a notifier that modifies [PasswordValidationState].
class PasswordValidationStateNotifier
    extends StateNotifier<PasswordValidationState> {
  late final PasswordValidationState _defaultState;

  /// Construct and initialize the [PasswordValidationStateNotifier] with
  /// the default [state].
  PasswordValidationStateNotifier(PasswordValidationState state)
      : super(state) {
    _defaultState = state;
  }

  /// Validate if the given [password] meets or not
  /// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
  void validate(String password) {
    state = state.copyWith(
      newPassLengthAccepted: password.length >= Config.passwordMinLength,
      newHasNumber: hasNumberPattern.allMatches(password).isNotEmpty,
      newHasSpecialChar: hasSpecialCharPattern.allMatches(password).isNotEmpty,
      newHasLowercaseChar: hasLowercasePattern.allMatches(password).isNotEmpty,
      newHasUppercaseChar: hasUppercasePattern.allMatches(password).isNotEmpty,
    );
  }

  /// Reset the state to the default state.
  void reset() {
    state = _defaultState;
  }
}
