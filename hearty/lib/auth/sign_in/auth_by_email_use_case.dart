/// Defines a contract for a use case that authenticates a user by email and
/// password.
abstract class AuthByEmailUseCase {
  /// Authenticates a user by email and password.
  ///
  /// Returns a [Future] that completes.
  Future<void> execute(String email, String password);
}
