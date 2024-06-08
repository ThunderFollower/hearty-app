import 'dart:math';

import 'package:flutter/material.dart';

/// Calculate the height of a text button for the given build [context].
///
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18293&t=g3S2hritP0rdIDIC-1)
double calculateTextButtonHeight(BuildContext context) {
  final theme = Theme.of(context);
  final mediaQuery = MediaQuery.of(context);

  final style = theme.textTheme.bodyLarge;
  final fontHeight = style?.height ?? _fontHeight;
  final fontSize = style?.fontSize ?? _fontSize;
  final lineHeight = fontHeight * fontSize * mediaQuery.textScaleFactor;

  return max(lineHeight.ceilToDouble(), _minHeight);
}

const _fontHeight = 1.2;
const _fontSize = 14.0;
const _minHeight = 48.0;
