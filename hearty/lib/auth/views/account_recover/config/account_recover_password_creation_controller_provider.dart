import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../../core/views.dart';
import '../../../auth.dart';
import '../controller/account_recover_password_creation_controller.dart';
import '../controller/account_recover_password_creation_controller_impl.dart';

/// Provides an instance of [AccountRecoverPasswordCreationController] for
/// the account recovery flow.
final accountRecoverPasswordCreationControllerProvider = Provider.family
    .autoDispose<AccountRecoverPasswordCreationController, String>(
  (ref, email) => AccountRecoverPasswordCreationControllerImpl(
    ref.watch(accountRecoveryPasswordInteractorProvider),
    ref.watch(routerProvider),
    ref.watch(showSuccessNotificationProvider),
    ref.watch(showErrorNotificationProvider),
    Logger(),
    email: email,
  ),
);
