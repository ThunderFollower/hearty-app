import 'package:flutter/widgets.dart';

/// Defines the state of a password validation. See also
/// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
@immutable
class PasswordValidationState {
  /// True when the length of the password meets the password requirements.
  final bool passLengthAccepted;

  /// True when the amount of numbers in the password meets the
  /// password requirements.
  final bool hasNumber;

  /// True when the amount of special symbols in the password meets the
  /// password requirements.
  final bool hasSpecialChar;

  /// True when the amount of small letters in the password meets the
  /// password requirements.
  final bool hasLowercaseChar;

  /// True when the amount of capital letters in the password meets the
  /// password requirements.
  final bool hasUppercaseChar;

  const PasswordValidationState({
    this.passLengthAccepted = false,
    this.hasNumber = false,
    this.hasSpecialChar = false,
    this.hasLowercaseChar = false,
    this.hasUppercaseChar = false,
  });

  /// Clone this [PasswordValidationState] object with slightly different content.
  PasswordValidationState copyWith({
    bool? newPassLengthAccepted,
    bool? newHasNumber,
    bool? newHasSpecialChar,
    bool? newHasLowercaseChar,
    bool? newHasUppercaseChar,
  }) {
    return PasswordValidationState(
      passLengthAccepted: newPassLengthAccepted ?? passLengthAccepted,
      hasNumber: newHasNumber ?? hasNumber,
      hasSpecialChar: newHasSpecialChar ?? hasSpecialChar,
      hasLowercaseChar: newHasLowercaseChar ?? hasLowercaseChar,
      hasUppercaseChar: newHasUppercaseChar ?? hasUppercaseChar,
    );
  }
}
