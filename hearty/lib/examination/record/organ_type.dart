import 'package:flutter/material.dart';

import '../../core/views.dart';
import '../../generated/locale_keys.g.dart';

/// type of examination
enum OrganType {
  heart,
  lungs,
}

extension OrganTypeExtension on OrganType {
  String get name =>
      this == OrganType.heart ? LocaleKeys.Heart : LocaleKeys.Lungs;

  String get nameRevert =>
      this == OrganType.heart ? LocaleKeys.Lungs : LocaleKeys.Heart;

  Widget icon({double size = 24}) {
    return this == OrganType.heart
        ? Icon(
            AppIcons.heart,
            size: size,
          )
        : Icon(
            AppIcons.lungs,
            size: size,
          );
  }

  Widget iconRevert({double size = 24}) {
    return this == OrganType.heart
        ? Icon(
            AppIcons.lungs,
            size: size,
          )
        : Icon(
            AppIcons.heart,
            size: size,
          );
  }
}
