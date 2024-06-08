import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import 'email_send_countdown_container.dart';

const _bodyPadding = EdgeInsets.only(
  left: middleIndent,
  right: middleIndent,
  bottom: veryHighIndent,
);

/// Defines an information page asking a user to check for an email or
/// request it again.
class EmailSendBodyContainer extends StatelessWidget {
  /// The main body text, content.
  final String text;

  /// The title of the back button.
  final String backButtonTitle;

  /// The callback is called on the back button tap.
  final VoidCallback? onBack;

  /// The callback is called on the resend button tap.
  final VoidCallback? onResend;

  /// The callback is called on the email button tap.
  final VoidCallback? onOpenEmailApp;

  const EmailSendBodyContainer({
    super.key,
    required this.text,
    required this.backButtonTitle,
    this.onBack,
    this.onResend,
    this.onOpenEmailApp,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: _bodyPadding,
        child: _container(context),
      );

  Widget _container(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _children(context),
      );

  List<Widget> _children(BuildContext context) => [
        const Spacer(),
        _successIcon(),
        const SizedBox(height: 44),
        _textWidget(),
        const SizedBox(height: middleIndent),
        _openEmailAppButton(context),
        const SizedBox(height: middleIndent),
        EmailSendCountdownContainer(onResend: onResend),
        const Spacer(),
        _backButton(),
      ];

  Icon _successIcon() => const Icon(
        AppIcons.success,
        color: Colors.pink,
        size: 72,
      );

  Text _textWidget() => Text(
        text,
        textAlign: TextAlign.center,
        style: textStyleOfRegular14,
      );

  Widget _openEmailAppButton(BuildContext context) => StrokeButton(
        width: extraHighSize,
        height: veryHighSize,
        fontSize: regularFontSize,
        title: LocaleKeys.Open_email_app.tr(),
        onPressed: onOpenEmailApp,
      );

  Widget _backButton() => RoundCornersButton(
        title: backButtonTitle,
        onTap: onBack,
      );
}
