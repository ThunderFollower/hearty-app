import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';

class LegalDocumentsButton extends ConsumerWidget {
  /// Creates a new [LegalDocumentsButton] and sets the [onPressed] callback
  /// that will be called when a button is clicked.
  const LegalDocumentsButton({this.onPressed});

  /// The callback is called when a user has pressed the button.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final bodyMedium = theme.textTheme.bodyMedium;
    final textStyle = bodyMedium?.copyWith(overflow: TextOverflow.ellipsis);
    final style = TextButton.styleFrom(
      foregroundColor: theme.colorScheme.secondaryContainer,
      disabledForegroundColor: theme.colorScheme.secondary,
      textStyle: textStyle,
    ).merge(theme.textButtonTheme.style);

    final text = Text(LocaleKeys.Legal_Documents.tr());
    final button = TextButton(
      onPressed: onPressed,
      key: _legalDocumentsButtonKey,
      child: text,
    );

    final data = TextButtonThemeData(style: style);
    return TextButtonTheme(data: data, child: button);
  }
}

const _legalDocumentsButtonKey = Key('legal_docs_btn');
