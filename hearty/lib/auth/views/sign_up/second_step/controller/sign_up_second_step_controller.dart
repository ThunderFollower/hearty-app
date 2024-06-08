import '../../../../auth.dart';

/// A contract that defines the methods for controlling the second step of the
/// sign-up process.
abstract class SignUpSecondStepController {
  /// Creates a new user with the given [password].
  ///
  /// After the user is created, the navigation stack is reset and the user is
  /// navigated to the next page.
  ///
  /// Throws an [SignUpException] if the user could not be created.
  Future<void> createUser(String password);
}
