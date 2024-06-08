import '../entities/auth_token.dart';

/// Defines a repository managing [AuthToken] entity.
abstract class AuthTokenRepository {
  /// Authenticate a user with [email] and [password] on a device with
  /// the given [deviceIdentifier].
  ///
  /// On success, returns a Future object that is completed with
  /// an [AuthToken] object.
  Future<AuthToken> signIn({
    required String email,
    required String password,
    required String deviceIdentifier,
  });

  /// Authorize the user by signing a document with the given [documentId].
  ///
  /// On success, returns a Future object that is completed with
  /// an [AuthToken] object.
  Future<AuthToken> authorize({required String documentId});

  /// Refresh access token using the given [refreshToken].
  ///
  /// On success, returns a Future object that is completed with
  /// an [AuthToken] object.
  Future<AuthToken> refresh(String refreshToken);

  /// Generate a one-time password to authenticate the device with the given
  /// [deviceIdentifier]. Additionally specifies [userAgent] of the device.
  ///
  /// Returns a Future object that is completed.
  Future<void> generateOneTimePassword({
    required String deviceIdentifier,
    required String userAgent,
  });

  /// Authenticate the device with [deviceIdentifier] using [oneTimePassword].
  /// Additionally specifies [userAgent] of the device.
  ///
  ///
  /// On success, returns a Future object that is completed with
  /// an [AuthToken] object.
  Future<AuthToken> authenticate(
    String oneTimePassword, {
    required String deviceIdentifier,
    required String userAgent,
  });
}
