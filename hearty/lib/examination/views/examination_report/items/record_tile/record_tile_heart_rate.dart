part of 'record_tile.dart';

class _HeartRate extends StatelessWidget {
  final int? value;

  const _HeartRate(this.value);

  @override
  Widget build(BuildContext context) {
    if (value == null || value == 0) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final color = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.labelMedium?.copyWith(color: color);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const LocalImage(assetPath: _heartRateIconPath),
        const SizedBox(width: _smallestIndent),
        Text('$value', style: textStyle),
        const SizedBox(width: belowLowIndent),
      ],
    );
  }
}
