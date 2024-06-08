import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account/credentials_service.dart';
import '../../authentication/ports/auth_token_repository.dart';
import '../../authentication/token_service.dart';
import '../../common/device_identifier_service.dart';
import '../auth_by_email_use_case.dart';

/// Defines the application's business logic for signing in.
class SignInInteractor implements AuthByEmailUseCase {
  SignInInteractor(
    this.repository,
    this.emailController,
    this.credentialsService,
    this.declickerSettingController,
    this.deviceIdentifierService,
    this.tokenService,
  );

  final AuthTokenRepository repository;
  final StateController<String> emailController;
  final CredentialsService credentialsService;
  final StateController<bool> declickerSettingController;
  final DeviceIdentifierService deviceIdentifierService;
  final TokenService tokenService;

  @override
  Future<void> execute(String email, String password) async {
    final login = email.toLowerCase();
    emailController.state = login;
    await tokenService.clear();
    final deviceIdentifier =
        await deviceIdentifierService.getDeviceIdentifier();

    final tokens = await repository.signIn(
      email: login,
      password: password,
      deviceIdentifier: deviceIdentifier,
    );

    await tokenService.update(tokens);
    await credentialsService.save(login: login, password: password);
    declickerSettingController.state = true;
  }
}
