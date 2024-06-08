import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'password_validation_state.dart';
import 'password_validation_state_notifier.dart';

/// Provides the state of validation of the user's password.
final passwordValidationStateProvider = StateNotifierProvider.autoDispose<
    PasswordValidationStateNotifier, PasswordValidationState>(
  (_) => PasswordValidationStateNotifier(const PasswordValidationState()),
);
