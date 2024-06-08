import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/text_style_constants.dart';

/// The green alert indicates a successful or positive action.
class SuccessAlert extends SnackBar {
  /// Create and initialize a green alert box with the given [message].
  SuccessAlert._({
    required String message,
  }) : super(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.green,
          content: Text(message, style: textStyleOfAlertText),
        );

  /// Create a greed alert box with the given [message].
  factory SuccessAlert.fromMessage(String message) {
    return SuccessAlert._(
      message: message,
    );
  }
}
