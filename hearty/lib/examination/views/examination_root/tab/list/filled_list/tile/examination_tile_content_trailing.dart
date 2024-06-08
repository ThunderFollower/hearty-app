part of 'examination_tile.dart';

class _ContentTrailing extends ConsumerWidget {
  final String examinationId;
  static const width = 100.0;
  static const maxScale = 1.0;

  const _ContentTrailing(this.examinationId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final state = ref.watch(provider);
    final ratio = MediaQuery.sizeOf(context).width / standardUiSize.width;
    final scale = min(ratio, maxScale);

    final trailing = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        __RecordNumber(state.amountOfHeartRecords, icon: AppIcons.heart),
        const SizedBox(width: belowLowIndent),
        __RecordNumber(state.amountOfLungRecords, icon: AppIcons.lungs),
      ],
    );

    return SizedBox(width: width * scale, child: trailing);
  }
}

class __RecordNumber extends StatelessWidget {
  final IconData? icon;
  final int? number;

  const __RecordNumber(this.number, {this.icon});

  @override
  Widget build(BuildContext context) {
    if (number == null) return const __RecordNumberSkeleton();

    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.onPrimary;
    final textColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: textColor);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(icon, size: lowIndent, color: iconColor),
        const SizedBox(width: halfOfLowestIndent),
        Text('$number', style: textStyle),
      ],
    );
  }
}

class __RecordNumberSkeleton extends StatelessWidget {
  const __RecordNumberSkeleton();

  static const count = 2;

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.sizeOf(context).width / standardUiSize.width;
    final scale = min(ratio, _ContentTrailing.maxScale);

    final style = SkeletonLineStyle(
      height: 20,
      width: (_ContentTrailing.width * 0.75 - belowLowIndent) / count * scale,
      alignment: Alignment.topRight,
    );

    return SkeletonLine(style: style);
  }
}
