import 'package:flutter/material.dart';

import 'app_fonts.dart';
import 'app_theme_colors.dart';

final _indicator = BoxDecoration(
  borderRadius: BorderRadius.circular(25.0),
  color: appLightColorScheme.secondary,
);

/// Defines a light theme for a tab bar.
///
/// Tab Bar example:
/// [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=11613%3A45137)
final appLightTabBarTheme = TabBarTheme(
  indicator: _indicator,
  labelColor: appLightColorScheme.onSecondary,
  unselectedLabelColor: appLightColorScheme.onSecondaryContainer,
  labelStyle: mediumFont14,
  unselectedLabelStyle: mediumFont14,
);
