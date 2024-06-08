import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../account/index.dart';
import '../authentication/config/auth_token_repository_provider.dart';
import '../authentication/index.dart';
import '../common/device_identifier_service.dart';
import 'auth_by_email_use_case.dart';
import 'impl/sign_in_interactor.dart';

/// Provides the application's business logic for signing in.
final signInInteractorProvider = Provider.autoDispose<AuthByEmailUseCase>(
  (ref) => SignInInteractor(
    ref.watch(authTokenRepositoryProvider),
    ref.read(emailProvider.notifier),
    ref.watch(credentialsServiceProvider),
    ref.read(declickerSettingProvider.notifier),
    ref.watch(deviceIdentifierService),
    ref.watch(tokenService),
  ),
);
