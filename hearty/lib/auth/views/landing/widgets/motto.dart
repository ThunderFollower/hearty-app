import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../generated/locale_keys.g.dart';

/// A widget that displays the app's motto.
class MottoWidget extends StatelessWidget {
  const MottoWidget({super.key});

  @override
  Widget build(BuildContext context) => Text(
        LocaleKeys.Landing_Motto.tr(),
        key: _appSloganKey,
        style: Theme.of(context).textTheme.headlineMedium,
      );
}

const _appSloganKey = Key('motto_widget');
