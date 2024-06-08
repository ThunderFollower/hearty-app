import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/locale_keys.g.dart';

/// A widget that displays an error message when the new password entered by a
/// user matches their previous one.
///
/// This widget displays a localized string, centered it within the widget's
/// bounding box.
class PasswordConflictNotification extends StatelessWidget {
  const PasswordConflictNotification();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.Password_should_not_match_the_previous_one.tr(),
      textAlign: TextAlign.center,
    );
  }
}
