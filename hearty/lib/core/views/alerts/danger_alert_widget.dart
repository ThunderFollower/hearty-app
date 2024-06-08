import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_constants.dart';

/// This alert box indicates dangerous or contradictory actions.
/// It is a red floating alert that is used to warn the user about
/// the consequences of the action.
class DangerAlert extends SnackBar {
  /// Create and initialize an alert box with the given [message].
  DangerAlert._({
    required String message,
  }) : super(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.red,
          content: Text(message, style: textStyleOfAlertText),
        );

  /// Create and alert box with a string representing the given [error].
  factory DangerAlert.fromError(dynamic error) {
    return DangerAlert._(
      message: error.toString(),
    );
  }

  /// Create an alert box with the given [message].
  factory DangerAlert.fromMessage(String message) {
    return DangerAlert._(
      message: message,
    );
  }
}
