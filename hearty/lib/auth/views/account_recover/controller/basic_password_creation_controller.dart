import 'package:auto_route/auto_route.dart';
import 'package:flutter/services.dart';

import '../../../../app_router.gr.dart';
import '../../../auth.dart';
import 'account_recover_password_creation_controller.dart';

/// Defines an implementation of the [AccountRecoverPasswordCreationController]
/// for the sign-up password creation screen
/// and the account recovery password creation screen.
class BasicPasswordCreationController
    implements AccountRecoverPasswordCreationController {
  /// Creates a new instance of the [BasicPasswordCreationController] with the
  /// [passwordSetup] use case.
  const BasicPasswordCreationController(this.passwordSetup, this.router);

  /// The use case to register a password.
  final PasswordSetupUseCase passwordSetup;

  /// The router to navigate to the next screen.
  final StackRouter router;

  @override
  Future<void> register(
    String password, {
    required String securityToken,
  }) async {
    // Set the new password and authenticate the user. After that, let's
    // clean up the routing stack and
    // complete 2-factor authentication for this device.
    await passwordSetup.execute(
      password,
      securityToken: securityToken,
    );

    TextInput.finishAutofillContext();

    router.popUntilRoot();
    router.push(TwoFactorAuthRoute());
  }
}
