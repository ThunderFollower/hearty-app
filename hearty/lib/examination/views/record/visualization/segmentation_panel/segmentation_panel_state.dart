part of 'segmentation_panel.dart';

class _SegmentationPanelState extends ConsumerState<SegmentationPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => wrap(
        _Content(
          segments: widget.segments,
          padding: widget.padding,
          width: widget.width,
        ),
      );

  Widget wrap(Widget child) => RecordAnimation(
        width: widget.width,
        recordId: widget.recordId,
        margin: widget.margin,
        child: RepaintBoundary(child: child),
      );
}
