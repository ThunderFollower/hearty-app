import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../two_factor_auth_state_provider.dart';
import 'code_controller_provider.dart';
import 'constants.dart';
import 'device_authentication_phase.dart';

final _borderRadius = BorderRadius.circular(lowestIndent);

final _defaultDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: _borderRadius,
);
final _focusedDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: _borderRadius,
  border: Border.all(color: Colors.pink),
);

final _errorDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: _borderRadius,
  border: Border.all(color: AppColors.red),
);

final _defaultPinTheme = PinTheme(
  height: 54,
  width: 40,
  decoration: _defaultDecoration,
  textStyle: textStyleOfPageTitle,
);

final _focusedPinTheme = PinTheme(
  height: 54,
  width: 40,
  decoration: _focusedDecoration,
  textStyle: textStyleOfPageTitle,
);

final _errorPinTheme = PinTheme(
  height: 54,
  width: 40,
  decoration: _errorDecoration,
  textStyle: textStyleOfPageTitle,
);

/// Defines a form for confirmation code.
class CodeForm extends ConsumerWidget {
  const CodeForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorSelection = twoFactorAuthStateProvider.select(
      (value) => value.phase == DeviceAuthenticationPhase.error,
    );

    final hasError = ref.watch(errorSelection);
    final controller = ref.watch(codeControllerProvider);

    return Center(
      child: Pinput(
        autofocus: true,
        crossAxisAlignment: CrossAxisAlignment.center,
        length: pinCodeLength,
        showCursor: false,
        controller: controller.editController,
        focusNode: controller.focusNode,
        defaultPinTheme: _defaultPinTheme,
        focusedPinTheme: _focusedPinTheme,
        errorPinTheme: _errorPinTheme,
        onChanged: controller.updateCode,
        forceErrorState: hasError,
        errorText: LocaleKeys.The_confirmation_code_is_invalid.tr(),
        errorTextStyle: const TextStyle(fontSize: 12, color: AppColors.red),
      ),
    );
  }
}
