import '../entities/index.dart';

/// An abstract repository that manages user authentication profiles.
abstract class AuthProfileRepository {
  /// Signs up a user with the given email and password, and returns a
  /// [Future] of their authentication profile.
  ///
  /// If a user with the given email already exists, an exception is thrown.
  Future<AuthProfile> signUpByEmail(String email, String password);

  /// Deletes the current user's authentication profile. If successful, the
  /// method returns a [Future] that completes successfully with no value.
  ///
  /// This operation cannot be undone, and all data associated with the user
  /// will be permanently removed from the backend API and local storage.
  Future<void> deleteProfile();

  /// Refreshes the access and refresh tokens (JWT) of the provided
  /// [AuthProfile] by requesting new tokens from the server.
  ///
  /// Returns a [Future] that completes with the updated [AuthProfile]
  /// containing the new tokens. If the user is not signed in or the tokens
  /// cannot be refreshed, an exception is thrown.
  Future<AuthProfile> refresh(AuthProfile profile);
}
