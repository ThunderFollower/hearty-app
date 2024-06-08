part of 'segmented_oscillogram.dart';

class _SegmentedOscillogramState extends ConsumerState<SegmentedOscillogram> {
  late Size actualSize;

  @override
  void initState() {
    actualSize = Size.zero;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MeasureSize(
        onChange: _handleSizeChanged,
        child: _buildErrorOrContent(),
      );

  void _handleSizeChanged(Size size) => setState(() => actualSize = size);

  Widget _buildErrorOrContent() =>
      widget.dataSet.isEmpty ? const RecordError() : _buildContent();

  Widget _buildContent() => RecordAnimation(
        width: widget.width,
        recordId: widget.recordId,
        margin: widget.margin,
        child: _buildStack(),
      );

  Widget _buildStack() => Stack(
        children: [
          _buildPaint(),
          ..._buildSegmentMarks() ?? [],
        ],
      );

  Widget _buildPaint() {
    final height = actualSize.height - segmentationPanelHeight;
    final width = widget.width + widget.extraSectionsPadding;
    return _wrap(
      CustomPaint(
        size: Size(width, height),
        painter: _buildPainter(),
      ),
    );
  }

  Widget _wrap(Widget widget) => RepaintBoundary(child: widget);

  CustomPainter _buildPainter() => OscillogramPainter(
        width: widget.width,
        dataSet: widget.dataSet,
        lineColor: Theme.of(context).colorScheme.secondary,
        lineWidth: widget.lineWidth,
        maxValue: widget.dataSet.map((value) => value.abs()).reduce(math.max),
        segments: widget.segments,
      );

  Iterable<Widget>? _buildSegmentMarks() => widget.segments?.map(
        (segment) => OscillogramSegment(
          label: segment.label,
          start: widget.timestampToPixels(segment.start),
          end: widget.timestampToPixels(segment.end),
          type: segment.type,
          height: actualSize.height,
        ),
      );
}
