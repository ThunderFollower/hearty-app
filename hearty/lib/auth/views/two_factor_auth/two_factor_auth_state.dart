import 'code/device_authentication_phase.dart';

/// The state of the device authentication process.
class TwoFactorAuthState {
  /// The phase of the device authentication process.
  DeviceAuthenticationPhase phase;

  /// The countdown timer for the device authentication process.
  int? countdown;

  /// Creates a [TwoFactorAuthState] with the given [phase] and [countdown].
  TwoFactorAuthState({
    this.phase = DeviceAuthenticationPhase.pending,
    this.countdown,
  });

  /// Create a copy of this [TwoFactorAuthState] but with the given [phase]
  /// and [countdown].
  TwoFactorAuthState copyWith({
    DeviceAuthenticationPhase? phase,
    int? countdown,
  }) =>
      TwoFactorAuthState(
        phase: phase ?? this.phase,
        countdown: countdown ?? this.countdown,
      );
}
