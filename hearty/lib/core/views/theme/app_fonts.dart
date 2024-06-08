import 'package:flutter/material.dart';

/// Defines a text style for font 10.
const _font10 = TextStyle(
  debugLabel: 'font10',
  fontSize: 10.0,
  height: 14.0 / 10.0,
  // The letter spacing is 0.2em (2%).
  letterSpacing: 0.02 * 10,
);

/// Defines a text style for font 12.
const _font12 = TextStyle(
  debugLabel: 'font12',
  fontSize: 12.0,
  height: 16.0 / 12.0,
  // The letter spacing is 0.2em (2%).
  letterSpacing: 0.02 * 16,
);

/// Defines a text style for font 14.
const _font14 = TextStyle(
  debugLabel: 'font14',
  fontSize: 14.0,
  height: 20.0 / 14.0,
  // The letter spacing is 0.2em (2%).
  letterSpacing: 0.02 * 14,
);

/// Defines a text style for font 18.
const _font18 = TextStyle(
  debugLabel: 'font18',
  fontSize: 18.0,
  height: 24.0 / 18.0,
  // The letter spacing is 0.2em (2%).
  letterSpacing: 0.02 * 18,
);

/// Defines a regular/normal (w400) font of size 10.
final regularFont10 = _font10.copyWith(fontWeight: FontWeight.normal);

/// Defines a regular/normal (w400) font of size 12.
final regularFont12 = _font12.copyWith(fontWeight: FontWeight.normal);

/// Defines a semi-bold (w600) font of size 12.
final semiBoldFont12 = _font12.copyWith(fontWeight: FontWeight.w600);

/// Defines a regular/normal (w400) font of size 14.
final regularFont14 = _font14.copyWith(fontWeight: FontWeight.normal);

/// Defines a medium (w500) font of size 14.
final mediumFont14 = _font14.copyWith(fontWeight: FontWeight.w500);

/// Defines a regular/normal (w400) font of size 18.
final regularFont18 = _font18.copyWith(fontWeight: FontWeight.normal);

/// Defines a medium (w500) font of size 18.
final mediumFont18 = _font18.copyWith(fontWeight: FontWeight.w500);
