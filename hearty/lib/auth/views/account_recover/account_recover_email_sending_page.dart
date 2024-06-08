import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/locale_keys.g.dart';
import '../base/index.dart';
import 'config/account_recover_email_sending_controller_provider.dart';

/// Defines an information page asking a user to check for
/// the Reset Password email or request it again.
@RoutePage()
class AccountRecoverEmailSendingPage extends EmailSendingPage {
  @override
  ProviderBase<EmailSendingController> get controllerProvider =>
      accountRecoverEmailSendingControllerProvider;

  /// Create and initialize [AccountRecoverEmailSendingPage] with the
  /// given [email].
  AccountRecoverEmailSendingPage({
    required String email,
    Key? key,
  }) : super(
          email,
          key: key,
          title: LocaleKeys.Reset_Password.tr(),
          text: LocaleKeys.Email_is_sent.tr(),
          backButtonTitle: LocaleKeys.Return_to_Login.tr(),
        );
}
