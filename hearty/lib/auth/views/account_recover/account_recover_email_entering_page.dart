import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../generated/locale_keys.g.dart';
import '../base/index.dart';
import 'config/account_recover_email_entering_controller_provider.dart';

/// Defines the page to enter an e-mail address to get a password reset
/// to recover access to a user account.
@RoutePage()
class AccountRecoverEmailEnteringPage extends EmailEnteringPage {
  /// Creates a page that allows users to reset their passwords.
  /// If [email] is not null, the email form will be pre-filled.
  AccountRecoverEmailEnteringPage({String? email})
      : super(
          title: LocaleKeys.Reset_Password.tr(),
          text: LocaleKeys.Enter_the_email_address_associated_with_your_account
              .tr(),
          submitText: LocaleKeys.Reset.tr(),
          initialEmail: email,
        );

  @override
  ProviderBase<EmailEnteringController> get controllerProvider =>
      accountRecoverEmailEnteringControllerProvider;
}
