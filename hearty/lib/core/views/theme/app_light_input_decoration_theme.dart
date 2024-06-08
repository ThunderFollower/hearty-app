import 'package:flutter/material.dart';

import 'app_theme_colors.dart';
import 'indentation_constants.dart';

/// Defines a light theme of input decorator.
///
/// See [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2532%3A10312&t=Bpijm9wsxygYY9ed-1)
final appLightInputDecorationTheme = InputDecorationTheme(
  contentPadding: _contentPadding,
  filled: true,
  fillColor: appLightColorScheme.primaryContainer,
  border: _noBorder,
  enabledBorder: _noBorder,
  disabledBorder: _noBorder,
  focusedBorder: _defaultBorder,
  errorBorder: _errorBorder,
  hintStyle: _hintStyle,
  // It hides the text of symbols counter.
  counterStyle: const TextStyle(fontSize: 0.0),
);

/// Defines text padding.
///
/// The left padding is 24px, the top and bottom are 18px, and the right is 16px.
///
/// All together with content size 20px,
///  an input height should be 18 + 20 +18 = 56px
const _contentPadding = EdgeInsets.fromLTRB(
  // Left
  middleIndent,
  // Top
  aboveLowIndent,
  // Right
  lowIndent,
  // Bottom
  aboveLowIndent,
);
final _borderRadius = BorderRadius.circular(28.0);

const _noBorderSide = BorderSide(
  style: BorderStyle.none,
  color: Colors.transparent,
);
final _secondaryBorderSide = BorderSide(color: appLightColorScheme.secondary);
final _errorBorderSize = BorderSide(color: appLightColorScheme.error);

final _noBorder = OutlineInputBorder(
  borderSide: _noBorderSide,
  borderRadius: _borderRadius,
);

final _defaultBorder = OutlineInputBorder(
  borderSide: _secondaryBorderSide,
  borderRadius: _borderRadius,
);

final _errorBorder = OutlineInputBorder(
  borderSide: _errorBorderSize,
  borderRadius: _borderRadius,
);

final _hintStyle = TextStyle(
  debugLabel: 'hintStyle',
  color: appLightColorScheme.onTertiaryContainer,
);
