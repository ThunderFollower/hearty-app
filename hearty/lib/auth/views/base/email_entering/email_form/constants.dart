import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/views.dart';
import '../../../../../core/views/theme/app_typography.dart';
import '../../../../../generated/locale_keys.g.dart';

/// Defines the default decoration for email input fields.
final emailDecoration = InputDecoration(
  hintText: LocaleKeys.Email.tr(),
  fillColor: Colors.white,
  hintStyle: appTypography.englishLike.bodyMedium?.copyWith(
    color: AppColors.grey.shade500,
  ),
  counterText: '',
  contentPadding: const EdgeInsets.symmetric(horizontal: belowMediumIndent),
);

/// Defines a length limit on email addresses.
///
/// As described in
/// [RFC3696 Errata ID 1690](https://www.rfc-editor.org/errata_search.php?rfc=3696)
/// , there is a length limit on email addresses. That limit is a maximum of 64
/// characters (octets) in the "local part" (before the "@") and a maximum
/// of 255 characters (octets) in the domain part (after the "@") for a total
/// length of 320 characters.
const emailAddressMaxLength = 320;

/// Defines the key of the submit button of a form.
const formSubmitKey = Key('submit');

/// Defines the key of the email input field of a form.
const formEmailKey = Key('email');
