import 'package:flutter/material.dart';

import '../../../../core/views.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip({
    super.key,
    required this.onTap,
    required this.chipLabel,
    required this.isSelected,
  });

  final Function(String chipLabel) onTap;
  final String chipLabel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primaryContainer;
    final inactiveColor = theme.colorScheme.onSecondaryContainer;
    final activeBackgroundColor = theme.colorScheme.secondary;
    final inactiveBackgroundColor = theme.colorScheme.surfaceTint;

    final chip = Chip(
      onDeleted: () => onTap(chipLabel),
      deleteIcon: _buildDeleteIcon(activeColor, inactiveColor),
      backgroundColor:
          isSelected ? activeBackgroundColor : inactiveBackgroundColor,
      label: _buildLabel(activeColor, inactiveColor, theme),
      padding: _padding,
    );
    return InkWell(onTap: () => onTap(chipLabel), child: chip);
  }

  Widget _buildDeleteIcon(Color activeColor, Color inactiveColor) => Icon(
        isSelected ? AppIcons.check : AppIcons.add,
        size: lowIndent,
        color: isSelected ? activeColor : inactiveColor,
      );

  Widget _buildLabel(
    Color activeColor,
    Color inactiveColor,
    ThemeData theme,
  ) {
    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: isSelected ? activeColor : inactiveColor,
      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
    );
    final text = Text(chipLabel, style: textStyle);

    return FittedBox(fit: BoxFit.scaleDown, child: text);
  }
}

const _padding = EdgeInsets.symmetric(
  horizontal: belowLowIndent,
  vertical: lowestIndent,
);
