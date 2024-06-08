import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/locale_keys.g.dart';

/// A widget that displays a success message when the user successfully changes
/// their password.
///
/// This widget displays a localized string which is centered within the
/// widget's bounding box.
class SuccessfulPasswordChangeNotification extends StatelessWidget {
  const SuccessfulPasswordChangeNotification();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.Password_changed_successfully.tr(),
      textAlign: TextAlign.center,
    );
  }
}
