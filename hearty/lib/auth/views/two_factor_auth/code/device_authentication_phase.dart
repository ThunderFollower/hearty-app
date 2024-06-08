/// Defines phases of the device authentication process.
enum DeviceAuthenticationPhase {
  /// Pending for a device authentication PIN-code.
  /// This state indicates that the user should enter the PIN code.
  pending,

  /// The device authentication process is ready to start.
  ready,

  /// The device authentication process is in progress.
  validating,

  /// The device authentication process is complete with an error.
  error,

  /// The device authentication process is complete with success.
  done,
}
