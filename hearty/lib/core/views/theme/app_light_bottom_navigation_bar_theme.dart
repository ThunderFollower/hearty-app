import 'package:flutter/material.dart';

import 'app_theme_colors.dart';

/// Defines a light theme for [BottomNavigationBar].
///
/// It is also used by a custom bottom bar for the main screen.
final appLightBottomNavigationBarTheme = BottomNavigationBarThemeData(
  // Primary color.
  selectedItemColor: appLightColorScheme.secondary,
  // Basic/400 color.
  unselectedItemColor: appLightColorScheme.secondaryContainer,
);
