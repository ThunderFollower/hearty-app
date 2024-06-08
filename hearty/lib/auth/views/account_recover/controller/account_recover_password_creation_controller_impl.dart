import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../../core/views.dart';
import '../../../auth.dart';
import '../../base/index.dart';
import 'basic_password_creation_controller.dart';
import 'notifications/index.dart';

/// This controller handles the creation of a new password during the account
/// recovery process. It extends the [BasicPasswordCreationController] and
/// overrides its register method to include additional validation steps and
/// more specific error handling.
class AccountRecoverPasswordCreationControllerImpl
    extends BasicPasswordCreationController {
  /// Constructor for the controller implementation.
  AccountRecoverPasswordCreationControllerImpl(
    super.passwordSetup,
    super.router,
    this._showNotification,
    this._showErrorNotification,
    this._logger, {
    required this.email,
  });

  /// The email address associated with the account recovery.
  final String email;

  /// A use case for displaying notifications.
  final ShowNotification _showNotification;

  /// A use case for displaying error notifications.
  final ShowNotification _showErrorNotification;

  /// A logger instance to log messages during the sign-up process.
  final Logger _logger;

  /// Registers a new password during the account recovery process.
  ///
  /// Throws [InvalidPasswordFormatException] if the password is the same as the email.
  @override
  Future<void> register(
    String password, {
    required String securityToken,
  }) async {
    if (_isPasswordSameAsEmail(password)) {
      _showPasswordLoginMatchError();
      return;
    }

    try {
      await super.register(password, securityToken: securityToken);
      _showSuccessNotification();
    } on UnauthorizedException catch (error, stackTrace) {
      _logger.e('The link is expired or malformed', error, stackTrace);
      _showUnauthorizedError();
    } on ConflictException catch (error, stackTrace) {
      _logger.e(
        'The new password conflicts with the current one',
        error,
        stackTrace,
      );
      _showConflictError();
    } catch (error, stackTrace) {
      _logger.e('Password recovery failed', error, stackTrace);
      _showGenericError(error);
    }
  }

  /// Checks if the given password is the same as the email, ignoring case and
  /// whitespace.
  bool _isPasswordSameAsEmail(String password) =>
      password.trim().toLowerCase() == email.trim().toLowerCase();

  void _showSuccessNotification() {
    _showNotification.execute(const SuccessfulPasswordChangeNotification());
  }

  void _showPasswordLoginMatchError() {
    _showErrorNotification.execute(const PasswordLoginMatchErrorNotification());
  }

  void _showUnauthorizedError() {
    _showErrorNotification.execute(const LinkExpirationNotification());
  }

  void _showConflictError() {
    _showErrorNotification.execute(const PasswordConflictNotification());
  }

  void _showGenericError([Object? error]) {
    _showErrorNotification.execute(GenericErrorNotification(error));
  }
}
