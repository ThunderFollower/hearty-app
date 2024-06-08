import 'package:flutter/material.dart';

/// Calculate the height of an input field for the given build [context].
///
/// [Style Guide](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=2532%3A10312&t=VfGrylRVjmaCcwx0-1)
double calculateInputHeight(BuildContext context) {
  final theme = Theme.of(context);
  final mediaQuery = MediaQuery.of(context);

  final contentPadding = theme.inputDecorationTheme.contentPadding;
  final verticalPadding = contentPadding?.vertical ?? _verticalPadding;

  final style = theme.textTheme.titleMedium;
  final fontHeight = style?.height ?? _fontHeight;
  final fontSize = style?.fontSize ?? _fontSize;
  final lineHeight = fontHeight * fontSize * mediaQuery.textScaleFactor;

  return lineHeight.ceil() + verticalPadding;
}

const _verticalPadding = 18.0 * 2;
const _fontHeight = 1.2;
const _fontSize = 14.0;
