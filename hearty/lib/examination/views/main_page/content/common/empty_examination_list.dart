import 'package:flutter/material.dart';

import '../../../../../core/views.dart';

/// Encapsulates presentation of a list with no examination tiles.
class EmptyExaminationList extends StatelessWidget {
  const EmptyExaminationList({
    super.key,
    this.title = 'Title of nothing',
    this.description = 'Description of There is nothing here',
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconView = _buildIcon(theme);
    final titleView = _buildTitle(theme);
    final descriptionView = _buildDescription(theme);

    final children = [
      iconView,
      const SizedBox(height: belowHightIndent),
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
      title,
      key: _noExamFieldKey,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget _buildDescription(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final style = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(
      description,
      textAlign: TextAlign.center,
      style: style,
      key: _noExamSubFieldKey,
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
const _noExamFieldKey = Key('no_exam_label_empty_state');
const _noExamSubFieldKey = Key('no_exam_sub_label_empty_state');
