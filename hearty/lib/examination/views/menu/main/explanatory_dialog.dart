import 'package:flutter/material.dart';
import '../../../../core/views/theme/indentation_constants.dart';
import 'info/info_widget.dart';

class ExplanatoryDialog extends StatelessWidget {
  const ExplanatoryDialog({
    required this.title,
    required this.description,
    required this.bodyInfo,
  });

  final String title;
  final String description;
  final String bodyInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final column = Column(
      children: [
        _buildTitle(theme),
        const SizedBox(height: lowestIndent),
        _buildDescription(theme),
        const SizedBox(height: lowIndent),
        InfoWidget(title: bodyInfo),
      ],
    );

    return Container(padding: _padding, child: column);
  }

  Widget _buildDescription(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(description, textAlign: TextAlign.center, style: textStyle);
  }

  Widget _buildTitle(ThemeData theme) {
    final textStyle = theme.textTheme.labelLarge;

    return Text(title, style: textStyle);
  }
}

const _padding = EdgeInsets.only(
  left: lowestIndent,
  right: lowestIndent,
  bottom: lowestIndent,
);
