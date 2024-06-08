import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_state.dart';

/// The controller for the sign-in page.
abstract class SignInController implements StateNotifier<SignInState> {
  /// Navigate back to the landing page.
  void back();

  /// Recovers access to a user's account when the user forgot the password.
  ///
  /// Shows a dialog with the option to send a password recovery email to the
  /// user's registered email address.
  void recoverAccount();

  /// Navigates a user to the Help Center if it's required.
  ///
  /// Shows a dialog with the option to navigate the user to the Help Center.
  void openHelpCenter();

  /// Signs up for a new account.
  ///
  /// Shows a dialog with the option to navigate the user to the sign-up page.
  void signUp();

  /// Authenticates with a biometric device.
  ///
  /// Attempts to authenticate the user with the biometric device.
  /// Shows an error if the authentication fails.
  void authenticateWithBiometric();

  /// Authenticates with a user's [email] and [password].
  ///
  /// Attempts to authenticate the user with the given email and password.
  /// Shows an error if the authentication fails.
  void authenticateWithEmail(String email, String password);

  /// Opens the stethoscope.
  ///
  /// Opens the stethoscope and updates the state accordingly.
  void openStethoscope();
}
