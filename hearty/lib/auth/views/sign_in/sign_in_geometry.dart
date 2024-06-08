import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/views.dart';
import 'login_form/constants.dart';

/// Encapsulates view logic calculating the layout geometry of the Sign In
/// screen.
///
/// The layouts geometry depends on many factors:
///
/// * The size of the screen.
/// * System's scaling factor of text.
/// * The current theme.
class SignInGeometry {
  /// Creates a new [SignInGeometry].
  const SignInGeometry._({
    required this.height,
    required this.bottomPadding,
    required this.textButtonMargin,
    required this.appBarPadding,
  });

  /// The maximum height of the content.
  final double height;

  /// The padding between the content and the page bottom.
  final double bottomPadding;

  /// The margin for text buttons.
  final double textButtonMargin;

  final double appBarPadding;

  /// Calculates and returns the geometry of layouts of the Sign In screen for
  /// the current build [context].
  ///
  /// This method resolves the scale of the screen, calculates the size and
  /// padding for the logo widget, and determines the bottom padding of the
  /// screen. It also calculates the size of the content area based on the
  /// height of the screen, and returns a [SignInGeometry] object containing
  /// these values.
  factory SignInGeometry.of(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final scale = _resolveScale(mediaQuery);
    final textButtonMargin = _calculateTextButtonMargin(mediaQuery, scale);
    final bottomPadding = _calculateBottomPadding(mediaQuery, scale);
    final appBarPadding = _calculateAppBarPadding(scale);

    final sizeBoxHeight = _calculateSizeBoxHeight(
      context,
      mediaQuery: mediaQuery,
      textButtonMargin: textButtonMargin,
      bottomPadding: bottomPadding,
      appBarPadding: appBarPadding,
    );

    return SignInGeometry._(
      height: sizeBoxHeight,
      bottomPadding: bottomPadding,
      textButtonMargin: textButtonMargin,
      appBarPadding: appBarPadding,
    );
  }
}

/// Resolves the scale of the screen based on the media query data.
double _resolveScale(MediaQueryData mediaQuery) {
  final screenScale = mediaQuery.size.height / _baseScreenHeight;
  return min(screenScale, _maxScale);
}

/// Calculates the height of the login form by taking the height of the inputs
/// and their margins, and adding the height of the submit button.
double _calculateFormHeight(BuildContext context, double buttonHeight) {
  // Calculate the height of the inputs.
  final inputHeight = calculateInputHeight(context);

  // Calculate the height of the input zone (inputs plus their margins).
  final inputZoneHeight = (inputHeight + logInFormMargin) * 2;

  // Return the total height of the login form (input zone height plus the
  // height of the submit button).
  return inputZoneHeight + buttonHeight;
}

/// Calculates the margin for text buttons based on the media query data and
/// the scale.
double _calculateTextButtonMargin(MediaQueryData mediaQuery, double scale) {
  final height = mediaQuery.size.height;
  final indent = height >= _smallScreenCap ? lowestIndent : belowLowIndent;
  return (indent * scale).ceilToDouble();
}

/// Calculates the bottom padding of the screen based on the media query data
/// and the scale.
double _calculateBottomPadding(MediaQueryData mediaQuery, double scale) {
  final height = mediaQuery.size.height;
  final indent = height >= _smallScreenCap ? veryHighIndent : _tinyIndent;
  return (indent * scale).ceilToDouble();
}

double _calculateAppBarPadding(double scale) {
  final height = AppBar().preferredSize.height + lowIndent;
  return (height * scale).ceilToDouble();
}

/// Calculates the minimum height needed to display all the content on the
/// sign-in screen.
///
/// This function takes into account the logo height, form height, text button
/// margin, and bottom padding.
///
/// It returns the larger of the minimum height calculated and the height of
/// the device's screen.
double _calculateSizeBoxHeight(
  BuildContext context, {
  required MediaQueryData mediaQuery,
  required double textButtonMargin,
  required double bottomPadding,
  required double appBarPadding,
}) {
  final buttonHeight = calculateButtonHeight(context);
  final formHeight = _calculateFormHeight(context, buttonHeight);
  final textButtonHeight = calculateTextButtonHeight(context);

  // Add up the height of each component of the sign-in screen
  final totalHeight = statusBarIndent +
      appBarPadding +
      formHeight +
      (textButtonMargin + textButtonHeight) * 2 +
      buttonHeight +
      bottomPadding;

  // Return the larger of the minimum height needed and the screen height
  // return totalHeight;
  return max(totalHeight, mediaQuery.size.height);
}

// The height of a reference screen (e.g., iPhone 11-14)
const _baseScreenHeight = 844.0;

// The maximum allowed scaling factor
const _maxScale = 1.0;

// The maximum height for a "small" screen (e.g., iPhone SE)
const _smallScreenCap = 700.0;

const _tinyIndent = 4.0;
