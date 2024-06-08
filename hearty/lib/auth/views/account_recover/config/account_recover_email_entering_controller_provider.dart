import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../base/index.dart';
import '../account_recover_email_entering_controller.dart';

/// Provides a page controller to enter an e-mail address to get a password reset
/// to recover access to a user account.
final accountRecoverEmailEnteringControllerProvider =
    Provider.autoDispose<EmailEnteringController>(
  (ref) => AccountRecoverEmailEnteringController(
    ref.watch(routerProvider),
  ),
);
