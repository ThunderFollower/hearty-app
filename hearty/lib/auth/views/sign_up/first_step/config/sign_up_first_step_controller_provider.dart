import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../core/views.dart';
import '../sign_up_email_entering_controller.dart';
import '../sign_up_first_step_controller.dart';

/// Provides a controller for the page where the user enters their email address
/// to sign up for a new account. This controller handles the navigation to the
/// next page after the email is entered.
final signUpFirstStepControllerProvider =
    Provider.autoDispose<SignUpEmailEnteringController>(
  (ref) => SignUpFirstStepController(
    ref.watch(routerProvider),
    _nextPath,
    _documentsPath,
    Logger(),
  ),
);

const _nextPath = '/sign-up-continue';
const _documentsPath = '/documents-list';
