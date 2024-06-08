import 'package:flutter/material.dart';

import 'app_circle_button_theme.dart';
import 'app_light_bottom_navigation_bar_theme.dart';
import 'app_light_cupertino_theme.dart';
import 'app_light_input_decoration_theme.dart';
import 'app_light_tab_bar_theme.dart';
import 'app_light_text_button_theme.dart';
import 'app_light_text_selection_theme.dart';
import 'app_theme_colors.dart';
import 'app_typography.dart';
import 'light_app_bar_theme.dart';
import 'switch_button_theme.dart';

/// Defines themes for the application.
class AppThemes {
  AppThemes._();

  /// The main theme of the application.
  static final mainTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: appLightColorScheme,
    typography: appTypography,
    primarySwatch: Colors.pink,
    canvasColor: Colors.white,
    fontFamily: 'Montserrat',
    inputDecorationTheme: appLightInputDecorationTheme,
    textSelectionTheme: appLightTextSelectionTheme,
    cupertinoOverrideTheme: appLightCupertinoTheme,
    switchTheme: switchButtonTheme,
    // It is also used by a custom bottom bar for the main screen.
    bottomNavigationBarTheme: appLightBottomNavigationBarTheme,
    tabBarTheme: appLightTabBarTheme,
    appBarTheme: lightAppBarTheme,
    textButtonTheme: appLightTextButtonTheme,
  );

  /// A theme for a circle button.
  static final circleButtonTheme = appLightCircleButtonThemeData;
}
