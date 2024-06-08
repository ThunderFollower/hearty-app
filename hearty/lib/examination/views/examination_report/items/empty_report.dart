import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/views/theme/app_icons.dart';
import '../../../../core/views/theme/indentation_constants.dart';
import '../../../../generated/locale_keys.g.dart';

class EmptyReport extends StatelessWidget {
  const EmptyReport({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconView = _buildIcon(theme);
    final titleView = _buildTitle(theme);
    final descriptionView = _buildDescription(theme);

    final children = [
      iconView,
      const SizedBox(height: lowIndent),
      titleView,
      const SizedBox(height: lowIndent),
      descriptionView,
    ];

    return _buildContent(children);
  }

  Widget _buildIcon(ThemeData theme) {
    final color = theme.colorScheme.onTertiary;
    return Icon(
      AppIcons.list,
      color: color,
      size: extremelyHightIndent,
    );
  }

  Widget _buildTitle(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;
    final style = theme.textTheme.titleLarge?.copyWith(color: color);

    return Text(
      LocaleKeys.ExaminationReport_EmptyReport_title.tr(),
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget _buildDescription(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final style = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(
      LocaleKeys.ExaminationReport_EmptyReport_body.tr(),
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget _buildContent(List<Widget> children) {
    final column = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );

    final padding = Padding(
      padding: _padding,
      child: column,
    );
    return Center(child: padding);
  }
}

const _padding = EdgeInsets.symmetric(horizontal: highIndent);
