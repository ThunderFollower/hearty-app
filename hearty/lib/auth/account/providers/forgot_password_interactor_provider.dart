import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../credentials_service.dart';
import '../impl/forgot_password_interactor.dart';
import '../password_request_use_case.dart';

/// Provides the [ForgotPasswordInteractor] instance.
final forgotPasswordInteractorProvider =
    Provider.autoDispose<PasswordRequestUseCase>(
  (ref) => ForgotPasswordInteractor(
    ref.read(credentialsServiceProvider),
  ),
);
