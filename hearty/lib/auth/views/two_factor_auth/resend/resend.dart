import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';

class Resend extends ConsumerWidget {
  final int? timer;
  final VoidCallback onPressed;
  final String text;

  const Resend({
    super.key,
    this.timer,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge;

    return Column(
      children: [
        _buildQuestionText(textStyle, theme),
        _buildActionText(textStyle, theme),
      ],
    );
  }

  TextButton _buildActionText(TextStyle? textStyle, ThemeData theme) {
    final actionTextColor = theme.colorScheme.onSurface;
    final actionTextStyle = textStyle?.copyWith(color: actionTextColor);

    final resendText = LocaleKeys.Resend.tr();
    final seconds = '$resendText ${LocaleKeys.in_number_sec.tr(
      args: [timer.toString()],
    )}';
    final buttonText = timer != null && timer! > 0 ? seconds : resendText;

    final text = Text(
      key: _resendButtonTextKey,
      buttonText,
      style: actionTextStyle,
    );

    return TextButton(
      key: _resendButtonKey,
      onPressed: onPressed,
      child: text,
    );
  }

  Widget _buildQuestionText(TextStyle? textStyle, ThemeData theme) {
    final questionTextColor = theme.colorScheme.secondaryContainer;
    final questionTextStyle = textStyle?.copyWith(color: questionTextColor);

    return Text(
      key: _resendQuestionKey,
      text,
      style: questionTextStyle,
    );
  }
}

const _resendButtonKey = Key('resend_button_key');
const _resendQuestionKey = Key('resend_question_key');
const _resendButtonTextKey = Key('resend_button_text_key');
