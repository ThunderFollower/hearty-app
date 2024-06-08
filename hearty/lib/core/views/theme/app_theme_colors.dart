import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Defines the light color schema.
final appLightColorScheme = ColorScheme.light(
  // Accent color, Examinations App Bar, etc.
  background: Colors.pink.shade100,

  // Color of pages (log-in, etc).
  primary: Colors.pink.shade100,
  // Color of page texts.
  onPrimary: AppColors.grey.shade900,
  // Color of dialogs, bottom sheets, side menu, documents,
  // input fields, etc.
  primaryContainer: Colors.white,
  // Hint color for input fields.
  onPrimaryContainer: AppColors.grey.shade700,
  //
  // Tags, active filter buttons, logos, active tabs, swipeable menu,
  // bottom bar icons, Oscillogram.
  secondary: Colors.pink,
  // Text and icon color on tags, swipeable menu icons, etc.
  onSecondary: Colors.white,
  // Alternative tag color, bottom bar icons color.
  secondaryContainer: AppColors.grey.shade400,
  // Alternative text and icon color on tags.
  onSecondaryContainer: AppColors.grey.shade900,
  //
  // Inactive filter buttons, tab bar background, guides background.
  tertiary: Colors.pink.shade100,
  // Color of icons and text of inactive filter buttons.
  onTertiary: Colors.pink,
  // Success alert background.
  tertiaryContainer: AppColors.green,
  // Email text on items, modal message body.
  onTertiaryContainer: AppColors.grey.shade500,
  //
  /// Text buttons color.
  onSurface: Colors.pink.shade700,
  //
  // Danger Alert background color; Color of validation errors.
  error: AppColors.red,
  // Error Snack Bar.
  errorContainer: AppColors.red.shade100,
  // Color of the warning message.
  onError: AppColors.red.shade900,

  // Color of the dots in the carousel
  onSurfaceVariant: AppColors.grey[150],
  // Divider color
  outline: Colors.pink.shade100,
  // Color of the video overlay.
  shadow: AppColors.overlay,
  // Additional info button color.
  onBackground: AppColors.grey.shade300,
  // Color of the inactive disease button.
  surfaceTint: AppColors.grey.shade50,
  // Success color
  outlineVariant: AppColors.green.shade100,
  // Color of the marketplace background.
  scrim: Colors.pink.shade900,
  // Attention text color.
  onErrorContainer: AppColors.brown,
  // Attention label color.
  surface: AppColors.orange,
  // Success text color.
  onInverseSurface: AppColors.green.shade900,
);
