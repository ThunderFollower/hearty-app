import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/views/theme/index.dart';
import '../../../../generated/locale_keys.g.dart';

class AttentionDialog extends StatelessWidget {
  const AttentionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleText = _buildTitleText(theme);
    final mainText = _buildMainText(theme);
    const sizedBox = SizedBox(height: lowIndent);
    final column = Column(children: [titleText, sizedBox, mainText, sizedBox]);

    return Container(padding: _padding, child: column);
  }

  Text _buildTitleText(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;
    final style = theme.textTheme.titleLarge?.copyWith(color: color);

    return Text(LocaleKeys.Attention.tr(), style: style);
  }

  Text _buildMainText(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final style = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(
      LocaleKeys.Exclude_any_identifiable_information.tr(),
      textAlign: TextAlign.center,
      style: style,
    );
  }
}

const _padding = EdgeInsets.symmetric(
  vertical: lowIndent,
  horizontal: lowestIndent,
);
