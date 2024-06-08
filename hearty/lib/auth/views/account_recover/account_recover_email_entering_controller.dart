import 'package:auto_route/auto_route.dart';

import '../../../app_router.gr.dart';
import '../base/index.dart';

/// Defines a page controller to enter an e-mail address to get a password reset
/// to recover access to a user account.
class AccountRecoverEmailEnteringController extends EmailEnteringController {
  /// The application's router.
  final StackRouter _router;

  /// Create and initialize [AccountRecoverEmailEnteringController].
  AccountRecoverEmailEnteringController(this._router);

  @override
  Future<void> execute(String email) async {
    await _router.replace(AccountRecoverEmailSendingRoute(email: email));
  }
}
