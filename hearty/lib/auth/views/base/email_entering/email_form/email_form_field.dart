import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'constants.dart';

/// Implements a [TextFormField] with the e-mail form field validator,
/// e-mail keyboard, and hint.
class EmailFormField extends TextFormField {
  /// Creates a mandatory [EmailFormField] that has keyboard focus by default.
  /// The [autoFocus] argument controls the default keyboard focus.
  /// If [controller] is null, this widget will construct
  /// a [TextEditingController] to control the editing of this field.
  /// The [onSubmitted] callback is called when the user finishes editing.
  factory EmailFormField({
    Key? key,
    TextEditingController? controller,
    bool autoFocus = true,
    ValueChanged<String>? onSubmitted,
  }) {
    final validator = MultiValidator([
      RequiredValidator(errorText: LocaleKeys.Email_is_required.tr()),
      EmailValidator(
        errorText: LocaleKeys.Please_recheck_your_email_format.tr(),
      ),
    ]);

    return EmailFormField._(
      key: key,
      controller: controller,
      validator: validator.call,
      autoFocus: autoFocus,
      onSubmitted: onSubmitted,
    );
  }

  /// Creates an optional [EmailFormField]. The optional field can be empty.
  /// The [autoFocus] argument controls the default keyboard focus.
  /// If [controller] is null, this widget will construct
  /// a [TextEditingController] to control the editing of this field.
  /// The [onSubmitted] callback is called when the user finishes editing.
  factory EmailFormField.optional({
    Key? key,
    TextEditingController? controller,
    bool autoFocus = false,
    ValueChanged<String>? onSubmitted,
  }) =>
      EmailFormField._(
        key: key,
        controller: controller,
        validator: EmailValidator(
          errorText: LocaleKeys.Please_recheck_your_email_format.tr(),
        ).call,
        autoFocus: autoFocus,
        onSubmitted: onSubmitted,
      );

  EmailFormField._({
    super.key,
    required String? Function(String?) super.validator,
    super.controller,
    bool autoFocus = false,
    ValueChanged<String>? onSubmitted,
  }) : super(
          keyboardType: TextInputType.emailAddress,
          decoration: emailDecoration,
          autocorrect: false,
          autofocus: autoFocus,
          maxLength: emailAddressMaxLength,
          onFieldSubmitted: onSubmitted,
          style: textStyleOfBlackPearlColorRegular14,
          autofillHints: const [AutofillHints.email],
        );
}
