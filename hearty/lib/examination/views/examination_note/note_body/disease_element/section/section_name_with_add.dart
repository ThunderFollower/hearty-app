import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/views.dart';
import '../../../../../../generated/locale_keys.g.dart';
import 'section_name.dart';

class SectionNameWithAdd extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SectionNameWithAdd({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mainColor = theme.colorScheme.onSurface;
    final additionTextStyle = theme.textTheme.bodyLarge?.copyWith(
      color: mainColor,
    );
    return Row(
      children: [
        SectionName(name: title),
        const Spacer(),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
          ),
          child: Row(
            children: [
              Text(
                LocaleKeys.Add.tr(),
                style: additionTextStyle,
              ),
              Text(
                'add_${title.replaceAll(' ', '_').toLowerCase()}_btn',
                style: const TextStyle(fontSize: 0),
                overflow: TextOverflow.clip,
              ),
              Icon(
                AppIcons.add,
                size: 16,
                color: mainColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
