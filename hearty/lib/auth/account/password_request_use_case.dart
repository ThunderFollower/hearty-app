/// Defines a contact of the application's business logic to create a password
/// request for a user.
///
/// In the first step, you [execute] this request by providing an email
/// address to get a confirmation email.
abstract class PasswordRequestUseCase {
  /// Register a password creation request with the given [email] address.
  ///
  /// Returns a [Future] object that completes.
  Future<void> execute(String email);
}
