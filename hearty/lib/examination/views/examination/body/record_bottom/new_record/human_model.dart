part of 'new_record.dart';

class _HumanModel extends StatelessWidget {
  final String? currentLabel;
  final Iterable<String> labels;
  final Iterable<VoidCallback> actions;
  final Iterable<Widget> icons;

  const _HumanModel({
    required this.labels,
    required this.actions,
    required this.icons,
    this.currentLabel,
  }) : assert(labels.length == actions.length && labels.length == icons.length);

  @override
  Widget build(BuildContext context) {
    final listView = ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: labels.length,
      itemBuilder: (_, index) => _PositionButton(
        labels: labels,
        actions: actions,
        icons: icons,
        index: index,
        currentLabel: currentLabel,
      ),
      separatorBuilder: (_, __) => const SizedBox(height: lowestIndent),
    );
    final height = (_itemHeight + lowestIndent) * labels.length;

    return SizedBox(height: height, width: double.infinity, child: listView);
  }
}

class _PositionButton extends StatelessWidget {
  const _PositionButton({
    required this.labels,
    required this.actions,
    required this.icons,
    required this.index,
    this.currentLabel,
  });

  final String? currentLabel;
  final int index;
  final Iterable<String> labels;
  final Iterable<VoidCallback> actions;
  final Iterable<Widget> icons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedColor = theme.colorScheme.primary.withOpacity(0.3);

    final bool isSelected = labels.elementAt(index) == currentLabel;

    final row = Row(
      children: [
        const Spacer(flex: _mediumFlex),
        icons.elementAt(index),
        const Spacer(),
        _buildText(isSelected, theme),
        const Spacer(flex: _mediumFlex),
      ],
    );
    return RoundCornersButton(
      height: _itemHeight,
      borderRadius: _borderRadius,
      onTap: () {
        context.router.pop();
        actions.elementAt(index).call();
      },
      gradient: isSelected ? AppGradients.blue1 : null,
      color: isSelected ? null : unselectedColor,
      child: row,
    );
  }

  Widget _buildText(bool currentChoice, ThemeData theme) {
    final selectedColor = theme.colorScheme.primaryContainer;
    final unselectedColor = theme.colorScheme.onPrimary;
    final textStyle = theme.textTheme.titleLarge?.copyWith(
      color: currentChoice ? selectedColor : unselectedColor,
    );
    final text = Text(
      labels.elementAt(index),
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
      style: textStyle,
    );

    return Flexible(
      flex: _bigFlex,
      child: FittedBox(fit: BoxFit.scaleDown, child: text),
    );
  }
}

const _borderRadius = BorderRadius.all(Radius.circular(belowHightIndent));
const _itemHeight = 72.0;

// These values correspond to the Figma design.
const _mediumFlex = 8;
const _bigFlex = 22;
