import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';

/// Encapsulates representation of the "Sign Up" button on the Login screen.
///
/// [Figma Design](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=11615%3A45953&t=hTriGN8YAees7BrO-1)
class ForgotPasswordButton extends ConsumerWidget {
  /// Creates a new [ForgotPasswordButton] and sets the [onPressed] callback
  /// that will be called when a button is clicked.
  const ForgotPasswordButton({super.key, this.onPressed});

  /// The callback is called when a user has pressed the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final bodyMedium = theme.textTheme.bodyMedium;
    final textStyle = bodyMedium?.copyWith(overflow: TextOverflow.ellipsis);
    final style = TextButton.styleFrom(
      foregroundColor: theme.colorScheme.secondaryContainer,
      disabledForegroundColor: theme.colorScheme.secondary.withOpacity(0.38),
      textStyle: textStyle,
    ).merge(theme.textButtonTheme.style);

    final text = Text(LocaleKeys.Forgot_password.tr());
    final button = TextButton(
      key: _forgotPasswordButtonKey,
      onPressed: onPressed,
      child: text,
    );

    final data = TextButtonThemeData(style: style);
    return TextButtonTheme(data: data, child: button);
  }
}

// Keys
const _forgotPasswordButtonKey = Key('forgot_password_btn');
