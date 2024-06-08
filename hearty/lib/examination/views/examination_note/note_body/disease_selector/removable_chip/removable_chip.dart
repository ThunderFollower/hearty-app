import 'package:flutter/material.dart';

import '../../../../../../core/views.dart';

class RemovableChip extends StatelessWidget {
  final Function(String chipLabel) deleteChip;
  final String chipLabel;

  const RemovableChip({
    super.key,
    required this.deleteChip,
    required this.chipLabel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.primaryContainer;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: textColor);
    return Chip(
      deleteIcon: const Icon(
        AppIcons.close,
        color: Colors.white,
        size: 16,
      ),
      onDeleted: () => deleteChip(chipLabel),
      backgroundColor: Colors.pink,
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          chipLabel,
          overflow: TextOverflow.ellipsis,
          maxLines: 10,
          style: textStyle,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}
