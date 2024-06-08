import 'package:auto_route/auto_route.dart';

import '../../../core/core.dart';
import '../../account/index.dart';
import 'notification/automatic_sign_out_notification.dart';

/// Guard responsible for checking the authentication state and
/// controlling navigation based on the state.
class AuthGuard implements AutoRouteGuard {
  /// Creates a new instance of AuthGuard.
  ///
  /// Requires [AuthProfileService] and [AsyncCommand] instances.
  const AuthGuard(
    this._service,
    this._showErrorNotification, {
    required this.path,
  });

  /// Authentication profile service to manage user authentication profiles.
  final AuthProfileService _service;

  /// A use case for displaying error notifications.
  final ShowNotification _showErrorNotification;

  /// The path to the login page.
  final String path;

  /// Called when navigation is attempted.
  ///
  /// Checks if the user profile exists and if it hasn't expired.
  /// If the profile doesn't exist or has expired, the user is signed out.
  /// If the profile exists and hasn't expired, navigation continues.
  /// In case of profile expiration, attempts to refresh the user profile.
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final profile = await _service.observeProfileChanges().first;
    if (await _canProceed(profile)) {
      resolver.next();
    } else {
      router.popUntilRoot();
      router.pushNamed(path);
      _showErrorMessage();
    }
  }

  /// Checks if navigation can proceed based on the profile's expiration and
  /// ability to refresh the current user.
  Future<bool> _canProceed(AuthProfile? profile) async {
    final expiresAt = profile?.expiresAt?.toUtc();
    final now = DateTime.now().toUtc();
    return expiresAt != null &&
        (expiresAt.isAfter(now) || await _service.refreshCurrentUser() != null);
  }

  /// Shows an error notification with a message indicating that the user has
  /// been logged out.
  void _showErrorMessage() {
    _showErrorNotification.execute(const AutomaticSignOutNotification());
  }
}
