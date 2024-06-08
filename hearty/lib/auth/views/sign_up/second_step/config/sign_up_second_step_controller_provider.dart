import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';
import '../../../../../core/views.dart';
import '../../../../auth.dart';
import '../controller/sign_up_second_step_controller.dart';
import '../controller/sign_up_second_step_controller_impl.dart';

/// Provider for the [SignUpSecondStepController] that takes an email as a
/// parameter.
final signUpSecondStepControllerProvider =
    Provider.family.autoDispose<SignUpSecondStepController, String>(
  (ref, email) {
    final twoFAUri = resolveTwoFactorAuthUri(showSuccessNotification: true);
    return SignUpSecondStepControllerImpl(
      ref.watch(routerProvider),
      twoFAUri.toString(),
      email,
      ref.watch(signUpByEmailProvider),
      Logger(),
      ref.watch(showErrorNotificationProvider),
    );
  },
);
