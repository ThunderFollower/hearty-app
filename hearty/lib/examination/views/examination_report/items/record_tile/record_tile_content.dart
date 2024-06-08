part of 'record_tile.dart';

class _TileContent extends StatelessWidget {
  final Widget? icon;
  final String? text;

  const _TileContent({
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final data = text;
    if (data == null || icon == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    return Row(
      children: [
        SizedBox(width: lowIndent, child: icon),
        const SizedBox(width: _smallestIndent),
        Text(data, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
