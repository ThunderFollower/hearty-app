import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views/index.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../base/email_entering/email_form/email_form.dart';
import 'config/sign_up_first_step_controller_provider.dart';

/// Defines the page to enter an e-mail address to sign up for a new account.
@RoutePage()
class SignUpFirstStepPage extends ConsumerStatefulWidget {
  /// Creates a page to sign up for a new account by email.
  /// If [email] is not null, the email form will be pre-filled.
  SignUpFirstStepPage({String? email})
      : title = LocaleKeys.Sign_Up.tr(),
        submitText = LocaleKeys.Continue.tr(),
        initialEmail = email;

  final String title;
  final String submitText;
  final String? initialEmail;

  @override
  ConsumerState<SignUpFirstStepPage> createState() => _SignUpFirstStepState();
}

class _SignUpFirstStepState extends ConsumerState<SignUpFirstStepPage> {
  ValueChanged<String>? onSubmitted;

  @override
  void initState() {
    super.initState();
    onSubmitted = submit;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primary;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AppScaffold(
        backgroundColor: backgroundColor,
        appBar: TitleBar.withBackButton(widget.title),
        body: body(),
      ),
    );
  }

  /// The main body widget of the page.
  Widget body() => Padding(
        padding: _bodyPadding,
        child: root(),
      );

  /// The root widget of the page's body.
  Widget root() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        EmailForm(
          initialEmail: widget.initialEmail,
          submitText: widget.submitText,
          onSubmitted: onSubmitted,
        ),
        const SizedBox(height: lowIndent),
        const Spacer(flex: 2),
      ],
    );
  }

  /// The callback is called on the submit button tap.
  Future<void> submit(String email) async {
    try {
      setState(() => onSubmitted = null);
      final controller = ref.watch(signUpFirstStepControllerProvider);

      await controller.submitEmail(email);
    } on Exception catch (error) {
      handlerError(error);
    } finally {
      if (mounted) setState(() => onSubmitted = submit);
    }
  }

  /// Show the error message to the user.
  void handlerError(Exception error) {
    ScaffoldMessenger.of(context).showSnackBar(
      DangerAlert.fromError(error),
    );
  }
}

const _bodyPadding = EdgeInsets.symmetric(
  horizontal: middleIndent,
  vertical: belowMediumIndent,
);
