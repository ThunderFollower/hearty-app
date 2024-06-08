import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../state/landing_state_provider.dart';

/// A custom button that, when clicked, opens the sign-up page.
class SignUpButtonWidget extends ConsumerWidget {
  const SignUpButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(landingStateProvider.notifier);
    return RoundCornersButton(
      key: _signupKey,
      title: LocaleKeys.Landing_SignUp.tr(),
      onTap: controller.openSignUp,
      height: calculateButtonHeight(context),
    );
  }
}

const _signupKey = Key('sign_up_key');
