part of 'segmented_spectrogram.dart';

class _SegmentedSpectrogramState extends ConsumerState<SegmentedSpectrogram> {
  late Size actualSize;
  late int bottomFrequency;
  late int topFrequency;
  late RangeValues frequencyRange;

  /// The lower frequency level is 20 Hz.
  static const defaultLowerBound = int.fromEnvironment(
    'LOWER_FREQUENCY',
    defaultValue: 20,
  );

  /// The highest frequency level after scaling is 1000 Hz for both heart and
  /// lung recordings.
  static const defaultUpperBound = int.fromEnvironment(
    'UPPER_FREQUENCY',
    defaultValue: 1000,
  );

  @override
  void initState() {
    actualSize = Size.zero;
    updateFrequencies();
    super.initState();
  }

  void updateFrequencies() {
    final interval = defaultUpperBound ~/ widget.scale;
    bottomFrequency = defaultLowerBound;
    topFrequency = bottomFrequency + interval;
    if (topFrequency - bottomFrequency < interval) {
      bottomFrequency = topFrequency - interval;
    }

    frequencyRange = RangeValues(
      bottomFrequency.toDouble(),
      topFrequency.toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    updateFrequencies();
    return MeasureSize(
      onChange: _handleSizeChanged,
      child: _buildErrorOrContent(),
    );
  }

  void _handleSizeChanged(Size size) => setState(() => actualSize = size);

  Widget _buildErrorOrContent() => widget.spectrogramImage.width == 1
      ? const RecordError()
      : _buildContent();

  Widget _buildContent() => Stack(
        children: [
          _buildScrollView(),
          _buildRuler(),
        ],
      );

  Widget _buildRuler() => FrequencyRuler(
        bottomFrequency: bottomFrequency,
        topFrequency: topFrequency,
        height: actualSize.height,
      );

  Widget _buildScrollView() => RecordAnimation(
        width: widget.width,
        recordId: widget.recordId,
        margin: widget.margin,
        child: _buildScrollableStack(),
      );

  Widget _buildScrollableStack() => Stack(
        children: [
          _buildTransformedImage(),
          ..._buildSegmentMarks() ?? [],
        ],
      );

  Widget _buildTransformedImage() {
    final transform = Matrix4.identity()
      ..scale(1.0, widget.scale, 1.0)
      ..translate(0.0, actualSize.height / widget.scale - actualSize.height);
    return wrap(
      Transform(
        transform: transform,
        child: _buildImage(),
      ),
    );
  }

  Widget wrap(Widget widget) => RepaintBoundary(child: widget);

  Widget _buildImage() => RawImage(
        width: widget.width,
        height: actualSize.height,
        image: widget.spectrogramImage,
        fit: BoxFit.fill,
      );

  Iterable<Widget>? _buildSegmentMarks() => widget.segments?.map(
        mapSegmentStateToSpectrogramSegment,
      );

  Widget mapSegmentStateToSpectrogramSegment(
    SegmentState segment,
  ) =>
      SpectrogramSegment(
        label: segment.label,
        start: widget.timestampToPixels(segment.start),
        end: widget.timestampToPixels(segment.end),
        type: segment.type,
        height: actualSize.height,
        frequency: segment.top,
        frequencyRange: frequencyRange,
      );
}
