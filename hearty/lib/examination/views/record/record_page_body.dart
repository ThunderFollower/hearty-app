part of 'record_page.dart';

class _Body extends ConsumerWidget {
  const _Body(this.recordId);

  final String? recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = recordId;
    if (id != null) {
      final provider = recordStateProvider(id);
      final oscillogramData = ref.watch(
        provider.select((state) => state.oscillogramData),
      );

      final controller = ref.watch(provider.notifier);
      return SegmentedVisualization(
        segments: ref.watch(provider.select((state) => state.segments)),
        hasMurmur: ref.watch(provider.select((state) => state.hasMurmur)),
        heartRate: ref.watch(provider.select((state) => state.heartRate)),
        isFine: ref.watch(provider.select((state) => state.isFine)),
        oscillogramData: oscillogramData,
        isSpectrogramMode: false,
        onChangeMode: controller.toggleMode,
        recordId: id,
        duration: ref.watch(provider.select((state) => state.duration)),
        scale: ref.watch(provider.select((state) => state.scale)),
        onScaleStart: controller.onScaleStart,
        onScaleUpdate: controller.onScaleUpdate,
        onScaleEnd: controller.onScaleEnd,
        onHorizontalDragDown: controller.onHorizontalDragDown,
        onHorizontalDragUpdate: controller.onHorizontalDragUpdate,
        onHorizontalDragEnd: controller.onHorizontalDragEnd,
        onHorizontalDragCancel: controller.onHorizontalDragCancel,
      );
    }
    return const SegmentedVisualization();
  }
}
