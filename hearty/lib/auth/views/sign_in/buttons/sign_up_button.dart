import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';

/// Encapsulates representation of the "Sign Up" button on the Login screen.
///
/// [Figma Design](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=11615%3A45953&t=hTriGN8YAees7BrO-1)
class SignUpButton extends StatelessWidget {
  /// Creates a new [SignUpButton] and sets the [onPressed] callback
  /// that will be called when a button is clicked.
  const SignUpButton({
    super.key,
    this.onPressed,
  });

  /// The callback is called when a user has pressed the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => StrokeButton(
        title: LocaleKeys.Sign_Up.tr(),
        onPressed: onPressed,
        enabled: onPressed != null,
        height: calculateButtonHeight(context),
      );
}
