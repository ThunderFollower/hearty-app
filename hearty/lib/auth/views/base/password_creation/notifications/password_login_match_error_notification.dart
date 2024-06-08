import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../generated/locale_keys.g.dart';

/// A widget that displays an error message when a user's password matches their
/// login.
///
/// This widget presents a localized string, advising users that their password
/// should not be identical to their login for security reasons.
/// The message is displayed in a centered alignment within the widget's
/// bounding box.
class PasswordLoginMatchErrorNotification extends StatelessWidget {
  const PasswordLoginMatchErrorNotification();

  @override
  Widget build(BuildContext context) => Text(
        LocaleKeys.NotesBody_Password_should_not_match_login.tr(),
        textAlign: TextAlign.center,
      );
}
