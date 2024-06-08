import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../../generated/locale_keys.g.dart';

/// A widget that displays a success message after a user successfully creates a
/// password.
///
/// This widget displays a localized string. The message is centered within the
/// widget's bounding box.
class SuccessfulPasswordCreationNotification extends StatelessWidget {
  const SuccessfulPasswordCreationNotification();

  @override
  Widget build(BuildContext context) => Text(
        LocaleKeys.Password_created_successfully.tr(),
        textAlign: TextAlign.center,
        key: _successfullPasswordCreationKey,
      );
}

const _successfullPasswordCreationKey =
    Key('successful_password_notification_key');
