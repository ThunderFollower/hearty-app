import 'package:flutter/material.dart';

import 'app_gradients.dart';
import 'app_theme_colors.dart';
import 'circle_button_theme/index.dart';

const _radius = 32.0;
final _decoration = BoxDecoration(
  gradient: AppGradients.blue1,
  shape: BoxShape.circle,
);

final _backgroundDecoration = BoxDecoration(
  gradient: AppGradients.blue3,
  shape: BoxShape.circle,
);

const _padding = EdgeInsets.all(8.0);

final _style = ElevatedButton.styleFrom(
  foregroundColor: appLightColorScheme.onSecondary,
  fixedSize: const Size.fromRadius(_radius),
);

/// Defines a light theme for a circle button.
final appLightCircleButtonThemeData = CircleButtonThemeData(
  backgroundDecoration: _backgroundDecoration,
  decoration: _decoration,
  padding: _padding,
  style: _style,
);
