import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../state/landing_state_provider.dart';

/// A custom button that, when clicked, opens the help center.
class HelpCenterButtonWidget extends ConsumerWidget {
  const HelpCenterButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(landingStateProvider.notifier);

    return AppTextButton(
      onPressed: controller.openHelpCenter,
      key: _helpCenterBtn,
      child: Text(LocaleKeys.Landing_HelpCenter.tr()),
    );
  }
}

const _helpCenterBtn = Key('help_center_btn_key');
