import 'package:flutter/material.dart';

/// Calculate the height of a button for the given build [context].
///
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2949%3A18293&t=VfGrylRVjmaCcwx0-1)
double calculateButtonHeight(BuildContext context) {
  final theme = Theme.of(context);
  final mediaQuery = MediaQuery.of(context);

  final style = theme.textTheme.labelLarge;
  final fontHeight = style?.height ?? _fontHeight;
  final fontSize = style?.fontSize ?? _fontSize;
  final lineHeight = fontHeight * fontSize * mediaQuery.textScaleFactor;

  return lineHeight.ceil() + _verticalPadding;
}

const _verticalPadding = 16.0 * 2.0;
const _fontHeight = 1.2;
const _fontSize = 18.0;
