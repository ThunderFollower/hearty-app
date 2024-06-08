import 'entities/user.dart';

/// Defines a contract of the application's business logic to finish
/// a password request.
///
/// In the first step, you need to register your request by providing
/// an email address to get a confirmation email.
///
/// In the final step, you [execute] the request with a confirmation token
/// from the confirmation email and a password string that meets
/// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
abstract class PasswordSetupUseCase {
  /// Complete a password creation request and set the given [password] as
  /// the [User] password.
  ///
  /// The [password] must meet
  /// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
  ///
  /// The [securityToken] confirms the user's identity.
  /// It should be taken from an email sent to the address specified in
  /// the [execute] method.
  ///
  /// Returns a [Future] completed with a [User] object.
  Future<User> execute(
    String password, {
    required String securityToken,
  });
}
