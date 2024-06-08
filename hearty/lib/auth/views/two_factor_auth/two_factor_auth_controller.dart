import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'two_factor_auth_state.dart';

/// Defines the interface for the controller of two factor auth page.
abstract class TwoFactorAuthController
    extends StateNotifier<TwoFactorAuthState> {
  /// Construct a new [TwoFactorAuthController].
  TwoFactorAuthController(super.state);

  /// Request get a code.
  ///
  /// Returns a completed [Future] when the request is done.
  Future<void> requestCode();

  /// Open an email app installed on the device.
  ///
  /// Returns a completed [Future] when the request is done.
  Future<void> openMailApp();

  /// Send the confirmation code to the server once the state is ready.
  ///
  /// Returns a completed [Future] when the request is done.
  Future<void> authenticate();

  /// Navigate back to the previous screen.
  void navigateBack();

  /// Show successful password creation notification
  void showSuccessNotification();
}
