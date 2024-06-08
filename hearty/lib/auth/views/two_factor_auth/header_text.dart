import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';

/// Defines the header of the 2-step authentication page.
class HeaderText extends StatelessWidget {
  const HeaderText();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleMedium;

    return Text(
      LocaleKeys.Please_authorize_your_device.tr(),
      textAlign: TextAlign.center,
      style: textStyle,
      key: _twoFADescription,
    );
  }
}

const _twoFADescription = Key('twoFADesc_key');
