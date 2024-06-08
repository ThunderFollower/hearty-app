import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/user_repository_provider.dart';
import '../impl/account_recovery_email_interactor.dart';
import '../password_request_use_case.dart';

/// Provide an instance of the [PasswordRequestUseCase] abstraction
/// that implements the application's business logic
/// to **Get a Password Reset** by email.
final accountRecoveryEmailInteractorProvider =
    Provider.autoDispose<PasswordRequestUseCase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AccountRecoveryEmailInteractor(userRepository);
});
