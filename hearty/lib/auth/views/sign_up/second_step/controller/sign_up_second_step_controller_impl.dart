import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';
import '../../../../../core/views.dart';
import '../../../../auth.dart';
import '../../../base/index.dart';
import 'sign_up_second_step_controller.dart';

/// Controller implementation for the second step of the sign-up process.
///
/// This controller is responsible for creating a new user with the given
/// password and navigating to the next page on successful creation. If an error
/// occurs during user creation, it logs an error and rethrows the exception.
class SignUpSecondStepControllerImpl implements SignUpSecondStepController {
  /// Creates a new instance of [SignUpSecondStepControllerImpl].
  ///
  /// [_router] is the router to use for navigating to the next page.
  /// [_nextPath] is the path of the next page to navigate to after the user is
  /// created.
  /// [_email] is the email address entered by the user in the previous step.
  /// [_signUp] is the use case for creating a new user.
  /// [_logger] is a logger instance to log messages during the sign-up process.
  SignUpSecondStepControllerImpl(
    this._router,
    this._nextPath,
    this._email,
    this._signUp,
    this._logger,
    this._showErrorNotification,
  );

  /// The email address entered by the user in the previous step.
  final String _email;

  /// The router to use for navigating to the next page.
  final StackRouter _router;

  /// The path of the next page to navigate to after the user is created.
  final String _nextPath;

  /// The use case for creating a new user.
  final AuthByEmailUseCase _signUp;

  /// A logger instance to log messages during the sign-up process.
  final Logger _logger;

  /// A use case for displaying error notifications.
  final ShowNotification _showErrorNotification;

  @override
  Future<void> createUser(String password) async {
    if (_areEmailAndPasswordEqual(password)) {
      _logger.w('The password matches the login');
      _showPasswordLoginMatchError();
      return;
    }

    try {
      await _signUp.execute(_email, password);
      TextInput.finishAutofillContext();
      // Avoid waiting for navigation to finish before releasing the associated
      // widgets, as this could cause performance issues by causing the user
      // interface to become unresponsive. Instead, release the widgets
      // immediately after starting the navigation process, even if the
      // navigation process is not yet complete.
      _navigate();
    } catch (error, stackTrace) {
      _logger.e('User could not be created', error, stackTrace);
      _showGenericError();
    }
  }

  bool _areEmailAndPasswordEqual(String password) =>
      password.toLowerCase() == _email.toLowerCase();

  /// Navigates to the [_nextPath].
  Future<void> _navigate() async {
    try {
      _router.popUntilRoot();
      await _router.replaceNamed<void>(_nextPath);
    } catch (error, stackTrace) {
      _logger.e('Cannot finish the sign-up', error, stackTrace);
      _showGenericError(error);
    }
  }

  void _showGenericError([Object? error]) {
    _showErrorNotification.execute(GenericErrorNotification(error));
  }

  void _showPasswordLoginMatchError() {
    _showErrorNotification.execute(const PasswordLoginMatchErrorNotification());
  }
}
