import 'package:flutter/material.dart';

import '../../views.dart';

/// Defines a light switch button theme for the application.
final switchButtonTheme = SwitchThemeData(
  trackColor: MaterialStateProperty.resolveWith(
    (states) => states.contains(MaterialState.selected)
        ? Colors.pink
        : AppColors.grey.shade300,
  ),
);
