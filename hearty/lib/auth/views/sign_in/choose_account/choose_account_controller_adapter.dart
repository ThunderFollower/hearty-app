import 'package:auto_route/auto_route.dart';

import '../../../auth.dart';
import 'choose_account_controller.dart';

/// Encapsulate the application's logic for the ChooseAccountDialog.
class ChooseAccountControllerAdapter implements ChooseAccountController {
  /// Construct a new [ChooseAccountControllerAdapter].
  ChooseAccountControllerAdapter(
    this.credentialsService,
    this.forgotPasswordUseCase,
    this.router,
  );

  /// The [CredentialsService] used to get all accounts.
  final CredentialsService credentialsService;

  /// The [PasswordRequestUseCase] used to forgot an account.
  final PasswordRequestUseCase forgotPasswordUseCase;

  /// The router used to navigate.
  final StackRouter router;

  @override
  Stream<List<Credentials>> allAccounts() => credentialsService.all();

  @override
  Future<void> dismiss([Credentials? credentials]) async {
    await router.pop(credentials);
  }

  @override
  Future<void> removeAccount(Credentials credentials) async {
    await forgotPasswordUseCase.execute(credentials.login);
  }
}
