import 'package:flutter/material.dart';

import '../../../../../core/views/theme/indentation_constants.dart';

class TextButtonTile extends StatelessWidget {
  const TextButtonTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.icon,
  });

  final String text;
  final VoidCallback onTap;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.bodyLarge?.copyWith(color: textColor);

    final leading = Icon(icon);
    final title = Text(text, style: textStyle);

    return ListTile(
      onTap: onTap,
      contentPadding: _contentPadding,
      leading: leading,
      iconColor: color,
      minLeadingWidth: 0,
      horizontalTitleGap: aboveLowestIndent,
      title: title,
    );
  }
}

const _contentPadding = EdgeInsets.only(left: lowestIndent);
