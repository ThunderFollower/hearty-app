import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

/// A widget for showing when the user has been logged out.
class AutomaticSignOutNotification extends StatelessWidget {
  const AutomaticSignOutNotification();

  @override
  Widget build(BuildContext context) => Text(
        LocaleKeys.You_have_been_automatically_logged_out.tr(),
        textAlign: TextAlign.center,
      );
}
