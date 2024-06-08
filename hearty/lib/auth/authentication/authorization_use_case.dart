/// Defines a contract authorizing a user.
abstract class AuthorizationUseCase {
  /// Constant constructor.
  const AuthorizationUseCase();

  /// Authorize the user using an object with specified [id].
  ///
  /// Returns a completed [Future].
  Future<void> execute(String id);
}
