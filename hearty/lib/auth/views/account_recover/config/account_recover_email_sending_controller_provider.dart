import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../../core/views.dart';
import '../../../auth.dart';
import '../../base/index.dart';

/// Provider of a controller for a page asking a user to check for
/// the Reset Password email or request it again.
final accountRecoverEmailSendingControllerProvider =
    Provider.autoDispose<EmailSendingController>(
  (ref) => EmailSendingController(
    ref.watch(accountRecoveryEmailInteractorProvider),
    ref.watch(routerProvider),
    ref.read(emailSendingCountdownProvider.notifier),
    ref.watch(openEmailAppProvider),
  ),
);
