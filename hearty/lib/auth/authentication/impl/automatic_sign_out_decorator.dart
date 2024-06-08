import '../../../core/core.dart';
import 'notification/automatic_sign_out_notification.dart';

/// Class to decorate the automatic sign out functionality
/// with the ability to show a Snackbar message after a successful sign out.
///
/// It uses an AsyncCommand to perform the sign out operation,
/// and a GlobalKey to get access to the current ScaffoldMessengerState.
class AutomaticSignOutDecorator implements AsyncCommand<bool> {
  /// Creates an instance of the AutomaticSignOutDecorator.
  ///
  /// The [_signOut] parameter represents the sign out command,
  /// and the [_showErrorNotification] represents the [ShowNotification] use case.
  const AutomaticSignOutDecorator(
    this._signOut,
    this._showErrorNotification,
  );

  /// The command to perform the sign out operation.
  final AsyncCommand<bool> _signOut;

  /// A use case for displaying error notifications.
  final ShowNotification _showErrorNotification;

  /// Executes the sign out command and,
  /// if it's successful, shows a Snackbar with a logout message.
  @override
  Future<bool> execute() async {
    if (await _signOut.execute()) {
      _showErrorMessage();
      return true;
    }
    return false;
  }

  /// Shows an error notification with a message indicating that the user has
  /// been logged out.
  void _showErrorMessage() {
    _showErrorNotification.execute(const AutomaticSignOutNotification());
  }
}
