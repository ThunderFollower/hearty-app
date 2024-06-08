part of 'record_tile.dart';

class _Timestamp extends StatelessWidget {
  final DateTime? value;

  const _Timestamp(this.value);

  @override
  Widget build(BuildContext context) {
    final localTime = value?.toLocal();
    if (localTime == null) return const SizedBox.shrink();

    final text = DateFormat.yMMMd().add_jm().format(localTime);
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimaryContainer;
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: color);

    return Row(
      children: [
        const SizedBox(width: _smallestIndent),
        Text(text, style: textStyle),
      ],
    );
  }
}
