import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';
import 'countdown_widget.dart';
import 'email_sending_countdown_provider.dart';

/// Defines a widget representing a view of a state of
/// the [emailSendingCountdownProvider].
class EmailSendCountdownContainer extends ConsumerWidget {
  /// The callback is called on the resend button tap.
  final VoidCallback? onResend;

  /// Construct a new [EmailSendCountdownContainer] widget.
  const EmailSendCountdownContainer({
    super.key,
    this.onResend,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countdown = ref.watch(emailSendingCountdownProvider);
    return CountdownWidget(
      countdown,
      text: LocaleKeys.Didnt_receive_the_email.tr(),
      onPressed: onResend,
      actionText: LocaleKeys.Send_it_again.tr(),
      counterText: LocaleKeys.Resend.tr(),
    );
  }
}
