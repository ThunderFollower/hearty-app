/// The state for the sign-in page.
class SignInState {
  /// Constructs an instance of [SignInState].
  const SignInState({
    this.isEnabled = true,
    this.canOpenStethoscope = false,
  });

  /// Indicates if the sign-in page is enabled.
  final bool isEnabled;

  /// Indicates if the stethoscope can be opened.
  final bool canOpenStethoscope;

  /// Returns a new [SignInState] instance with the same values.
  SignInState copyWith({
    bool? isEnabled,
    bool? canOpenStethoscope,
  }) =>
      SignInState(
        isEnabled: isEnabled ?? this.isEnabled,
        canOpenStethoscope: canOpenStethoscope ?? this.canOpenStethoscope,
      );
}
