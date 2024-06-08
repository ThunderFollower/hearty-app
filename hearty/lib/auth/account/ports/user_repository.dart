import '../entities/user.dart';

/// Defines a repository managing the [User] entity.
abstract class UserRepository {
  /// This method initiates the deferred creation of a new [User] entity
  /// with the given [email] address.
  ///
  /// Use the [createUser] to finish the user creation.
  ///
  /// Returns a [Future] object that is completed.
  @Deprecated('Use `AuthProfileRepository.signUpByEmail` instead.')
  Future<void> signUp(String email);

  /// Register a new [User] and set the given [password] as the [User] password.
  ///
  /// The [password] must meet
  /// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
  ///
  /// The [securityToken] confirms the user's identity.
  /// It should be taken from an email sent to the address specified in
  /// the [signUp] method.
  ///
  /// Returns a [Future] object that is completed with a [User] object.
  @Deprecated('Use `AuthProfileRepository.signUpByEmail` instead.')
  Future<User> createUser(String password, {required String securityToken});

  /// Get a password reset by the given [email].
  ///
  /// Use the [recoverPassword] method to finish the password resetting.
  ///
  /// Returns a [Future] that is completed.
  Future<void> doPasswordReset(String email);

  /// Recover access to an account by setting a new [password].
  ///
  /// The [password] must meet
  /// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
  ///
  /// The [securityToken] confirms the user's identity.
  /// It should be taken from an email sent to the address specified in
  /// the [doPasswordReset] method.
  ///
  /// Returns a [Future] object that is completed with a [User] object.
  Future<User> recoverPassword(
    String password, {
    required String securityToken,
  });

  /// Get the current user.
  ///
  /// Returns a [Future] object that is completed with a [User] object.
  Future<User> getUser();
}
