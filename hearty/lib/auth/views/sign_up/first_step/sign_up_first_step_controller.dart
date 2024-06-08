import 'package:auto_route/auto_route.dart';
import 'package:logger/logger.dart';
import 'sign_up_email_entering_controller.dart';

/// A controller for the first step in the sign-up process, where the user
/// enters their email address to create a new account.
class SignUpFirstStepController extends SignUpEmailEnteringController {
  /// Creates a new instance of [SignUpFirstStepController].
  ///
  /// [_router] is the router to use for navigating to the next page, and
  /// [_nextPath] is the path of the next page to navigate to after the email
  /// is entered.
  /// [_logger] is a logger instance to log messages during the sign-up process.
  SignUpFirstStepController(
    this._router,
    this._nextPath,
    this._documentsPath,
    this._logger,
  );

  /// The router to use for navigating to the next page.
  final StackRouter _router;

  /// The path of the next page to navigate to after the email is entered.
  final String _nextPath;

  /// The path of the page with legal documents to navigate to after
  /// clicking on the `Legal Documents` button.
  final String _documentsPath;

  /// A logger instance to log messages during the sign-up process.
  final Logger _logger;

  @override
  Future<void> submitEmail(String email) async {
    final path = _resolvePath(_nextPath, email);
    // Avoid waiting for navigation to finish before releasing the associated
    // widgets, as this could cause performance issues by causing the user
    // interface to become unresponsive. Instead, release the widgets
    // immediately after starting the navigation process, even if the navigation
    // process is not yet complete.
    _navigate(path);
  }

  /// Navigates to the given [path].
  Future<void> _navigate(String path) async {
    try {
      await _router.pushNamed<void>(path);
    } catch (e, stackTrace) {
      _logger.e('Cannot continue the sign-up', e, stackTrace);
    }
  }

  @override
  Future<void> showDocuments() => _router.pushNamed(_documentsPath);
}

/// Resolves the path to the next page by appending a query parameter with the
/// user's email address to the given [path].
String _resolvePath(String path, String email) =>
    '$path?email=${Uri.encodeQueryComponent(email)}';
