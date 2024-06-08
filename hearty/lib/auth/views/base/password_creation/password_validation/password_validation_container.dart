import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'detail/password_length_validation_container.dart';
import 'detail/password_lowercase_character_validation_container.dart';
import 'detail/password_number_character_validation_container.dart';
import 'detail/password_special_character_validation_container.dart';
import 'detail/password_uppercase_character_validation_container.dart';

/// Defines a widget representing a view of
/// the [PasswordValidationState] state.
class PasswordValidationContainer extends ConsumerWidget {
  const PasswordValidationContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(),
          const SizedBox(height: middleIndent),
          const PasswordLengthValidationContainer(),
          const PasswordNumberCharacterValidationContainer(),
          const PasswordSpecialCharacterValidationContainer(),
          const PasswordLowercaseCharacterValidationContainer(),
          const PasswordUppercaseCharacterValidationContainer(),
        ],
      ),
    );
  }

  Widget _header() => Center(child: _headerText());

  Text _headerText() => Text(
        LocaleKeys.Password_must_contain_at_least.tr(),
        style: _headerTextStyle(),
      );

  TextStyle _headerTextStyle() => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.grey[900],
      );
}

const _padding = EdgeInsets.only(bottom: 35);
