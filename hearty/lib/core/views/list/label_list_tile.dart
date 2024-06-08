import 'package:flutter/material.dart';

import '../theme/index.dart';

class LabelListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;

  const LabelListTile({
    super.key,
    required this.title,
    required this.onTap,
    this.padding = _defaultPadding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        visualDensity: VisualDensity.compact,
        onTap: onTap,
        contentPadding: padding,
        leading: _TileText(title: title, textStyle: textStyle),
      );
}

class _TileText extends StatelessWidget {
  const _TileText({
    required this.title,
    this.textStyle,
  });

  final String title;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: buildStyle(context),
      );

  TextStyle buildStyle(BuildContext context) =>
      textStyle ?? buildDefaultStyle(context);

  TextStyle buildDefaultStyle(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodyLarge ?? const TextStyle();
    return style.copyWith(color: theme.colorScheme.onPrimary);
  }
}

const _defaultPadding = EdgeInsets.only(left: lowestIndent);
