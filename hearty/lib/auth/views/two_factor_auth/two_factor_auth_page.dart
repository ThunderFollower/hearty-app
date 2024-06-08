import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import 'code/code_form.dart';
import 'code/device_authentication_phase.dart';
import 'header_text.dart';
import 'resend/resend.dart';
import 'two_factor_auth_controller.dart';
import 'two_factor_auth_state.dart';
import 'two_factor_auth_state_provider.dart';

/// Defines the page for 2-step authentication.
@RoutePage()
class TwoFactorAuthPage extends ConsumerStatefulWidget {
  const TwoFactorAuthPage({
    @QueryParam(showSuccessNotificationParam)
    this.showPasswordCreatedNotification = false,
  });

  final bool showPasswordCreatedNotification;

  @override
  ConsumerState createState() => _TwoFactorAuthState();
}

class _TwoFactorAuthState extends ConsumerState<TwoFactorAuthPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showPasswordCreatedNotification) {
        final controller = ref.read(twoFactorAuthStateProvider.notifier);
        controller.showSuccessNotification();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(twoFactorAuthStateProvider);
    final controller = ref.watch(twoFactorAuthStateProvider.notifier);

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: root(controller, context, state),
    );
  }

  Widget root(
    TwoFactorAuthController controller,
    BuildContext context,
    TwoFactorAuthState state,
  ) {
    final titleText = Text(
      key: _titleBarText,
      LocaleKeys.TwoFactorAuthPage_Title.tr(),
    );
    final fittedTitle = FittedBox(fit: BoxFit.scaleDown, child: titleText);

    return AppScaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: fittedTitle,
        leading: BackIconButton(
          key: _backButtonKey,
          onPressed: controller.navigateBack,
        ),
        leadingWidth: BackIconButton.leadingWidth,
        key: _twoFactorAuthKey,
      ),
      body: _scrollableArea(controller, context, state),
    );
  }

  SingleChildScrollView _scrollableArea(
    TwoFactorAuthController controller,
    BuildContext context,
    TwoFactorAuthState state,
  ) =>
      SingleChildScrollView(
        child: Padding(
          padding: _scrollPadding,
          child: _content(controller, context, state),
        ),
      );

  Column _content(
    TwoFactorAuthController controller,
    BuildContext context,
    TwoFactorAuthState state,
  ) =>
      Column(
        children: [
          const HeaderText(),
          const SizedBox(height: lowIndent),
          _openMailAppButton(controller, context),
          const SizedBox(height: extremelyHightIndent),
          _buildCodeFormWithContinueButton(state, controller),
          const SizedBox(height: lowIndent),
          _resendButton(state, controller),
        ],
      );

  Widget _buildCodeFormWithContinueButton(
    TwoFactorAuthState state,
    TwoFactorAuthController controller,
  ) {
    const paddingInTheStack = SizedBox(height: _paddingBetweenFormAndButton);
    final column = Column(
      children: [paddingInTheStack, _continueButton(state, controller)],
    );

    return Stack(children: [const CodeForm(key: _twoFACodeFieldKey), column]);
  }

  StrokeButton _openMailAppButton(
    TwoFactorAuthController controller,
    BuildContext context,
  ) =>
      StrokeButton(
        key: const Key('open-mail-app'),
        width: 166,
        height: 40,
        fontSize: 14,
        title: LocaleKeys.TwoFactorAuthPage_OpenMail.tr(),
        onPressed: controller.openMailApp,
      );

  RoundCornersButton _continueButton(
    TwoFactorAuthState state,
    TwoFactorAuthController controller,
  ) =>
      RoundCornersButton(
        key: _continueButtonKey,
        title: LocaleKeys.TwoFactorAuthPage_Continue.tr(),
        enabled: state.phase == DeviceAuthenticationPhase.ready,
        onTap: controller.authenticate,
      );

  Resend _resendButton(
    TwoFactorAuthState state,
    TwoFactorAuthController controller,
  ) =>
      Resend(
        text: LocaleKeys.TwoFactorAuthPage_Resend.tr(),
        timer: state.countdown,
        onPressed: controller.requestCode,
      );
}

const _scrollPadding = EdgeInsets.only(
  top: belowMediumIndent,
  left: middleIndent,
  right: middleIndent,
);
const _paddingBetweenFormAndButton = 112.0;
const _twoFactorAuthKey = Key('twoFA_key');
const _titleBarText = Key('title_bar_text');
const _backButtonKey = Key('back_button_key');
const _continueButtonKey = Key('continue_button_key');
const _twoFACodeFieldKey = Key('twoFA_code_field_key');
