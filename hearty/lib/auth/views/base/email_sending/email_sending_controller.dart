import 'package:auto_route/auto_route.dart';

import '../../../../core/core.dart';
import '../../../auth.dart';
import 'countdown_timer_notifier.dart';

/// Defines a controller for an information page asking a user to check for
/// an email or request it again.
class EmailSendingController {
  /// The use-case of a password reset.
  final PasswordRequestUseCase _passwordRequest;

  /// The application's router.
  final StackRouter _router;

  /// The controller for the countdown timer.
  final CountdownTimerNotifier _countdownTimerNotifier;

  /// A abstract command to open an email application.
  final OpenEmailAppUseCase _openEmailAppUseCase;

  /// Create and initialize [EmailSendingController].
  /// The [_passwordRequest] specifies  is used to recover the account.
  const EmailSendingController(
    this._passwordRequest,
    this._router,
    this._countdownTimerNotifier,
    this._openEmailAppUseCase,
  );

  // Back to the login page which is the root of the router.
  void navigateBack() => _router.popUntilRouteWithPath(authPath);

  /// Execute the [PasswordRequestUseCase] to get an email.
  Future<void> execute(String email) async {
    _countdownTimerNotifier.startTimer();
    try {
      await _passwordRequest.execute(email);
    } catch (_) {
      _countdownTimerNotifier.stopTimer();
      rethrow;
    }
  }

  /// Open an email app to check for the email.
  Future<void> openEmailApp() => _openEmailAppUseCase.execute();
}
