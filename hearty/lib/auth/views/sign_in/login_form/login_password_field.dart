import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../base/password_visibility/index.dart';

/// Encapsulates representation of the password input field.
class LoginPasswordField extends StatelessWidget {
  /// Creates a new [LoginPasswordField] that contains a [TextFormField].
  const LoginPasswordField({
    this.onSaved,
    this.onFieldSubmitted,
    this.focusNode,
  });

  /// This callback is called with the final value when saving the form.
  final void Function(String?)? onSaved;

  /// This callback is called with the final value when the user has done
  /// editing.
  final void Function(String?)? onFieldSubmitted;

  /// The keyboard focus for this widget.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) => HidablePasswordInputFormField(
        fieldKey: _key,
        hintText: LocaleKeys.Password.tr(),
        onSaved: onSaved,
        validator: _validator.call,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        autofillHints: const [AutofillHints.password],
      );
}

/// Defines the validator for the password input field.
final _validator = RequiredValidator(
  errorText: LocaleKeys.Password_is_required.tr(),
);

const _key = Key('login_password_field');
