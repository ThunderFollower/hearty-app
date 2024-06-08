import 'package:flutter/material.dart';

import 'app_theme_colors.dart';
import 'app_typography.dart';

/// Defines a light theme for [TextButton]s.
final appLightTextButtonTheme = TextButtonThemeData(
  style: _appLightButtonStyle,
);

final _appLightButtonStyle = TextButton.styleFrom(
  foregroundColor: appLightColorScheme.secondary,
  disabledForegroundColor:
      appLightColorScheme.secondaryContainer.withOpacity(0.38),
  enableFeedback: true,
  textStyle: appTypography.englishLike.bodyLarge,
);
