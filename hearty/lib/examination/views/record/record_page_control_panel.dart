part of 'record_page.dart';

class _ControlPanel extends ConsumerWidget {
  const _ControlPanel(this.recordId);

  final String? recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (recordId != null) {
      final provider = recordStateProvider(recordId!);
      final isAdvancedMode = ref.watch(
        provider.select((state) => state.isAdvancedMode),
      );
      final controller = ref.watch(provider.notifier);

      return PlaybackControls(
        filter: ref.watch(provider.select((state) => state.filter)),
        onFilterChanged: controller.setFilter,
        audioUri: ref.watch(provider.select((state) => state.audioUri)),
        isAdvancedMode: isAdvancedMode,
        isPlaying: ref.watch(provider.select((state) => state.isPlaying)),
        onPlay: controller.togglePlaying,
        speed: ref.watch(provider.select((state) => state.speed)),
        onSpeedChanged: controller.toggleSpeed,
      );
    }
    return const PlaybackControls();
  }
}
