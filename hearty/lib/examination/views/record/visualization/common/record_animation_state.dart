part of 'record_animation.dart';

class _RecordAnimationState extends ConsumerState<RecordAnimation> {
  late final ScrollController scroll;

  /// Current playback position.
  late Duration position;

  /// Audio duration.
  late Duration duration;

  @override
  void initState() {
    position = Duration.zero;
    duration = Duration.zero;
    scroll = ScrollController(
      initialScrollOffset: offset,
      keepScrollOffset: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    handleBuild();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: scroll,
      padding: widget.margin,
      child: widget.child,
    );
  }

  double get offset => calculateTimePositionInPixels(
        duration: duration,
        position: position,
        size: widget.width,
      );

  void handleBuild() {
    final provider = recordStateProvider(widget.recordId);
    position = ref.watch(provider.select(selectPosition));
    duration = ref.watch(provider.select(selectDuration));

    if (scroll.hasClients) scroll.jumpTo(offset);
  }

  static Duration selectPosition(RecordState state) =>
      state.position ?? Duration.zero;
  static Duration selectDuration(RecordState state) =>
      state.duration ?? Duration.zero;
}
