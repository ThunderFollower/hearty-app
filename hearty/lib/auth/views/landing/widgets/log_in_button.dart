import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../state/landing_state_provider.dart';

/// A custom button that, when clicked, opens the sing-in page.
class LogInButtonWidget extends ConsumerWidget {
  const LogInButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(landingStateProvider.notifier);
    return StrokeButton(
      title: LocaleKeys.Landing_LogIn.tr(),
      key: _loginButtonKey,
      onPressed: controller.openSignIn,
      height: calculateButtonHeight(context),
    );
  }
}

const _loginButtonKey = Key('login_btn_key');
