part of 'record_page.dart';

class _Header extends ConsumerWidget {
  const _Header(
    this.recordId, {
    this.mutable = true,
  });

  final String? recordId;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = recordId;
    if (id != null) {
      final provider = recordStateProvider(id);
      final controller = ref.watch(provider.notifier);
      return RecordHeader(
        mutable: mutable,
        spot: ref.watch(provider.select((state) => state.spot)),
        recordId: recordId,
        name: ref.watch(provider.select((state) => state.name)),
        createdAt: ref.watch(provider.select((state) => state.createdAt)),
        onBack: controller.dismiss,
        onDelete: controller.delete,
        onRecordAgain: controller.recordAgain,
      );
    }
    return const RecordHeader();
  }
}
