part of 'examination_tile.dart';

// Keys
const _listTileKey = Key('list_tile_key');

class _Content extends ConsumerWidget {
  final String examinationId;
  final bool? received;

  static const contentPadding = EdgeInsets.all(lowIndent);

  const _Content(
    this.examinationId, {
    this.received,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationTileStateProvider(examinationId);
    final controller = ref.watch(provider.notifier);
    final backgroundColor = Colors.pink.shade100.withOpacity(0.3);

    return _ListItem(
      key: _listTileKey,
      leading: _ContentLeading(examinationId),
      title: _ContentTitle(examinationId),
      subtitle: _ContentSubtitle(examinationId, received: received),
      enableFeedback: true,
      onTap: controller.handleTap,
      tileColor: backgroundColor,
      contentPadding: contentPadding,
    );
  }
}
