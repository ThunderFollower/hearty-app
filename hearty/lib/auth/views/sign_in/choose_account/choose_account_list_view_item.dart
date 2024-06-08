import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../core/views.dart';

final _borderRadius = BorderRadius.circular(lowIndent);
const _boxBorderRadius = BorderRadius.all(Radius.circular(lowIndent));
final _boxDecoration = BoxDecoration(
  color: Colors.pink,
  borderRadius: _borderRadius,
);
final _mainButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.centerLeft,
  backgroundColor: Colors.transparent,
  fixedSize: const Size(double.maxFinite, 64.0),
  elevation: 0,
  padding: const EdgeInsets.symmetric(horizontal: lowIndent),
  shape: const RoundedRectangleBorder(borderRadius: _boxBorderRadius),
);

/// Defines a list view item for the list view on the choose account dialog.
class ChooseAccountListViewItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onDeleteTap;

  const ChooseAccountListViewItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(borderRadius: _borderRadius, child: _rootContainer(theme));
  }

  Container _rootContainer(ThemeData theme) => Container(
        decoration: _boxDecoration,
        child: _workZone(theme),
      );

  Slidable _workZone(ThemeData theme) => Slidable(
        key: ValueKey(title),
        endActionPane: _leftActionPane(),
        child: _mainButtonContainer(theme),
      );

  DecoratedBox _mainButtonContainer(ThemeData theme) {
    final color = theme.colorScheme.primary;
    final decoration = BoxDecoration(
      borderRadius: _boxBorderRadius,
      color: color,
    );

    return DecoratedBox(decoration: decoration, child: _mainButton());
  }

  ActionPane _leftActionPane() => ActionPane(
        motion: const BehindMotion(),
        children: [_deleteButton()],
      );

  SlidableActionButton _deleteButton() => SlidableActionButton(
        icon: AppIcons.delete,
        onPressed: onDeleteTap,
      );

  ElevatedButton _mainButton() => ElevatedButton(
        onPressed: onTap,
        style: _mainButtonStyle,
        child: Text(title, style: textStyleOfBlackPearlColorRegular12),
      );
}
