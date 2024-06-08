import 'package:flutter/material.dart';

import 'app_fonts.dart';
import 'app_theme_colors.dart';

/// Defines the application's [Typography] configuration.
final appTypography = Typography(
  black: _appBlackTextTheme,
  englishLike: _appEnglishLikeTextTheme,
);

/// The default [TextStyle] for the light color scheme.
final _appBlackStyle = TextStyle(
  debugLabel: 'Black',
  color: appLightColorScheme.onPrimary,
  decoration: TextDecoration.none,
);

/// Defines the application [TextTheme] for the light color scheme.
final _appBlackTextTheme = TextTheme(
  displayLarge: _appBlackStyle.copyWith(debugLabel: 'Black displayLarge'),
  displayMedium: _appBlackStyle.copyWith(debugLabel: 'Black displayMedium'),
  displaySmall: _appBlackStyle.copyWith(debugLabel: 'Black displaySmall'),
  headlineLarge: _appBlackStyle.copyWith(debugLabel: 'Black headlineLarge'),
  headlineMedium: _appBlackStyle.copyWith(debugLabel: 'Black headlineMedium'),
  headlineSmall: _appBlackStyle.copyWith(debugLabel: 'Black headlineSmall'),
  titleLarge: _appBlackStyle.copyWith(debugLabel: 'Black titleLarge'),
  titleMedium: _appBlackStyle.copyWith(debugLabel: 'Black titleMedium'),
  titleSmall: _appBlackStyle.copyWith(debugLabel: 'Black titleSmall'),
  bodyLarge: _appBlackStyle.copyWith(debugLabel: 'Black bodyLarge'),
  bodyMedium: _appBlackStyle.copyWith(debugLabel: 'Black bodyMedium'),
  bodySmall: _appBlackStyle.copyWith(debugLabel: 'Black bodySmall'),
  labelLarge: _appBlackStyle.copyWith(debugLabel: 'Black labelLarge'),
  labelMedium: _appBlackStyle.copyWith(debugLabel: 'Black labelMedium'),
  labelSmall: _appBlackStyle.copyWith(debugLabel: 'Black labelSmall'),
);

/// The default [TextStyle] for alphabetic scripts like Latin, Cyrillic, etc.
const _appEnglishLikeTextStyle = TextStyle(
  debugLabel: 'englishLike',
  textBaseline: TextBaseline.alphabetic,
);

/// Used for high-emphasis text.
///
/// Example: Onboarding Guide
/// > Hold perpendicular to the body
final _headlineLarge = mediumFont18.copyWith(debugLabel: 'headlineLarge');

/// Used for middle sized high-emphasis text.
///
/// Example: Onboarding Guide
/// >  Avoid moving the phone during examination.
final _headlineMedium = regularFont18.copyWith(debugLabel: 'headlineMedium');

/// Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
/// and [AlertDialog.title]).
///
/// Example: Sign Up; Reset Password.
final _titleLarge = mediumFont18.copyWith(debugLabel: 'titleLarge');

/// Used for the primary text in lists and fields.
///
/// Example: Email; Password.
final _titleMedium = regularFont14.copyWith(debugLabel: 'titleMedium');

/// Largest of the body styles.
///
/// Example 1: Sign Up screen
/// > Resend in 28 sec.
///
/// Example 2: Main Screen tabs
/// > My Examinations | Shared With Me
final _bodyLarge = mediumFont14.copyWith(debugLabel: 'bodyLarge');

/// The default text style for [Material].
///
/// Example: Two-Factor Authentication
/// > Please authorize your device with the  confirmation code sent to your
/// email address.  Enter the confirmation code below.
final _bodyMedium = regularFont14.copyWith(debugLabel: 'bodyMedium');

/// Used for error text; [InputDecoration.errorStyle].
///
/// Example: Create Password
/// > Password does not meet the requirements
final _bodySmall = regularFont12.copyWith(debugLabel: 'bodySmall');

/// Used for text on [ElevatedButton], [TextButton] and [OutlinedButton].
///
/// Example: Login; Reset; Continue.
final _labelLarge = mediumFont18.copyWith(debugLabel: 'labelLarge');

/// Used for the number of lung and heart diseases.
final _labelMedium = semiBoldFont12.copyWith(debugLabel: 'labelMedium');

/// Used for text on a custom bottom bar.
final _labelSmall = regularFont10.copyWith(debugLabel: 'labelSmall');

/// Defines the application [TextTheme] for alphabetic scripts like Latin,
/// Cyrillic, etc.
final _appEnglishLikeTextTheme = TextTheme(
  // A medium (w500) font of size 18.
  titleLarge: _appEnglishLikeTextStyle.merge(_titleLarge),
  // A regular/normal (w400) font of size 14.
  titleMedium: _appEnglishLikeTextStyle.merge(_titleMedium),
  // A medium (w500) font of size 18.
  headlineLarge: _appEnglishLikeTextStyle.merge(_headlineLarge),
  // A regular/normal (w400) font of size 18.
  headlineMedium: _appEnglishLikeTextStyle.merge(_headlineMedium),
  // A medium (w500) font of size 14.
  bodyLarge: _appEnglishLikeTextStyle.merge(_bodyLarge),
  // A regular/normal (w400) font of size 14.
  bodyMedium: _appEnglishLikeTextStyle.merge(_bodyMedium),
  // A regular (w400) font of size 12.
  bodySmall: _appEnglishLikeTextStyle.merge(_bodySmall),
  // A medium (w500) font of size 18.
  labelLarge: _appEnglishLikeTextStyle.merge(_labelLarge),
  // A medium (w600) font of size 12.
  labelMedium: _appEnglishLikeTextStyle.merge(_labelMedium),
  // A regular (w400) font of size 10.
  labelSmall: _appEnglishLikeTextStyle.merge(_labelSmall),
);
