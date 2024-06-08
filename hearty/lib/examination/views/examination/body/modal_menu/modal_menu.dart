import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../../core/views.dart';

class ModalMenu extends StatelessWidget {
  final Iterable<String> labels;
  final Iterable<VoidCallback> actions;
  final String? currentLabel;
  final Iterable<Widget> icons;
  final double itemHeight;
  final double itemPadding;

  const ModalMenu({
    super.key,
    required this.labels,
    required this.actions,
    this.icons = const <Widget>[],
    this.currentLabel,
    this.itemHeight = 56,
    this.itemPadding = 8,
  }) : assert(labels.length == actions.length);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (itemHeight + itemPadding) * labels.length,
      width: double.infinity,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: labels.length,
        itemBuilder: _buildItem,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int i) {
    final theme = Theme.of(context);
    final unselectedColor = theme.colorScheme.primary.withOpacity(0.3);
    final bool hasIcon = icons.length > i;
    final bool currentChoice = labels.elementAt(i) == currentLabel;
    return RoundCornersButton(
      onTap: () {
        context.router.pop();
        actions.elementAt(i).call();
      },
      gradient: currentChoice ? AppGradients.blue1 : null,
      color: currentChoice ? null : unselectedColor,
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasIcon)
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: icons.elementAt(i),
              ),
            Text(
              labels.elementAt(i),
              overflow: TextOverflow.fade,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: currentChoice ? Colors.white : AppColors.grey[900],
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
