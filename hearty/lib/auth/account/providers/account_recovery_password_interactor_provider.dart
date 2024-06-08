import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../sign_in/sign_in_interactor_provider.dart';
import '../config/user_repository_provider.dart';
import '../impl/account_recovery_password_interactor.dart';
import '../password_setup_use_case.dart';

final accountRecoveryPasswordInteractorProvider =
    Provider.autoDispose<PasswordSetupUseCase>(
  (ref) => AccountRecoveryPasswordInteractor(
    ref.watch(userRepositoryProvider),
    ref.watch(signInInteractorProvider),
  ),
);
