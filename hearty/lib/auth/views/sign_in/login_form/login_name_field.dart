import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../base/email_entering/email_form/constants.dart';

/// Encapsulates representation of the login name input field.
class LoginNameField extends StatelessWidget {
  /// Creates a new [LoginNameField] that contains a [TextFormField].
  const LoginNameField({super.key, this.onSaved, this.focusNode});

  /// This callback is called with the final value when saving the form.
  final void Function(String?)? onSaved;

  /// The keyboard focus for this widget.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintTextColor = theme.colorScheme.onTertiaryContainer;
    final hintTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: hintTextColor,
    );
    final decoration = InputDecoration(
      hintText: LocaleKeys.Email.tr(),
      hintStyle: hintTextStyle,
    );
    return TextFormField(
      key: _loginNameFieldKey,
      autofillHints: const [AutofillHints.username],
      onSaved: onSaved,
      validator: _validator.call,
      focusNode: focusNode,
      autocorrect: false,
      autofocus: true,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: decoration,
      maxLength: emailAddressMaxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
    );
  }
}

/// Defines the validator for the login name input field.
final _validator = RequiredValidator(
  errorText: LocaleKeys.Email_is_required.tr(),
);

const _loginNameFieldKey = Key('login_name_field');
