import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/locale_keys.g.dart';

/// A widget that displays a notification message when a user attempts to open
/// the application with an expired or malformed deep link.
///
/// The notification message is localized and is displayed centrally within the
/// widget's bounding box.
class LinkExpirationNotification extends StatelessWidget {
  const LinkExpirationNotification();

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.The_link_is_expired_or_malformed.tr(),
      textAlign: TextAlign.center,
    );
  }
}
