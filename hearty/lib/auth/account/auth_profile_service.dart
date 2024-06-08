import 'dart:async';

import 'entities/auth_profile.dart';
import 'user_role.dart';

/// A service that handles authentication and user profile related operations.
abstract class AuthProfileService {
  /// Registers a user with the given [email] and [password].
  ///
  /// Throws a [SignUpException] if the registration fails.
  Future<void> signUpByEmail(String email, String password);

  /// Signs out the current user.
  Future<void> signOut();

  /// Returns a [Stream] that emits the current [AuthProfile] whenever it
  /// changes.
  ///
  /// The stream will emit `null` if the user is signed out or the [AuthProfile]
  /// is removed.
  ///
  /// The returned stream is a broadcast stream, and multiple subscriptions
  /// can listen to it at the same time.
  Stream<AuthProfile?> observeProfileChanges();

  /// Sets the role of the current user.
  Future<void> setCurrentUserRole(UserRole role);

  /// Deletes the current user's profile from the backend API and clears all
  /// data associated with the user from the local storage. This operation
  /// cannot be undone.
  ///
  /// Returns a [Future] that completes when the operation is finished.
  Future<void> deleteProfile();

  /// Returns `true` if there is a user profile or `false` otherwise.
  ///
  /// This property can be used to determine whether certain actions or UI
  /// elements should be enabled or disabled based on the user's profile.
  Future<bool> get isNotEmpty;

  /// Retrieves the latest [AuthProfile] of the current user from the server.
  ///
  /// Returns a [Future] that completes with the updated [AuthProfile] or
  /// `null` if the user is not signed in.
  Future<AuthProfile?> refreshCurrentUser();
}
