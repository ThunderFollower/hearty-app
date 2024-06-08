import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../generated/locale_keys.g.dart';
import '../password_validation_state.dart';
import '../password_validation_state_provider.dart';
import 'validation_widget.dart';

/// Defines a widget representing a view of
/// the [PasswordValidationState.hasLowercaseChar] state.
///
/// This widget depends on the [passwordValidationStateProvider] state provider.
class PasswordLowercaseCharacterValidationContainer extends ConsumerWidget {
  /// Construct a new [PasswordLowercaseCharacterValidationContainer] widget.
  const PasswordLowercaseCharacterValidationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validationState = ref.watch(
      passwordValidationStateProvider.select((value) => value.hasLowercaseChar),
    );
    return ValidationWidget(
      isValid: validationState,
      body: LocaleKeys.One_lowercase_letter.tr(),
    );
  }
}
