part of 'segmented_visualization.dart';

class _Body extends StatelessWidget {
  const _Body({
    required this.segments,
    required this.image,
    required this.dataSet,
    required this.heartRate,
    required this.hasMurmur,
    required this.isFine,
    required this.isSpectrogramMode,
    required this.onChangeMode,
    required this.recordId,
    required this.duration,
    required this.scale,
    required this.onScaleStart,
    required this.onScaleUpdate,
    required this.onScaleEnd,
    required this.onHorizontalDragDown,
    required this.onHorizontalDragUpdate,
    required this.onHorizontalDragEnd,
    required this.onHorizontalDragCancel,
  });

  final Iterable<SegmentState>? segments;
  final ui.Image? image;
  final Iterable<double>? dataSet;
  final bool? hasMurmur;
  final int? heartRate;
  final bool? isFine;

  /// Indicates if the spectrogram mode is active.
  final bool? isSpectrogramMode;
  final VoidCallback? onChangeMode;

  /// Identifier for the associated audio record.
  final String recordId;

  /// Represents the total duration of the audio.
  final Duration duration;

  final double scale;

  double get contentWidth => visualizationSize * scale;

  final GestureScaleStartCallback? onScaleStart;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleEndCallback? onScaleEnd;

  final GestureDragDownCallback? onHorizontalDragDown;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;

  /// The horizontal size of the visualization window.
  static const visualizationSize = int.fromEnvironment(
    'VISUALIZATION_SIZE',
    defaultValue: 2000,
  );

  @override
  Widget build(BuildContext context) {
    final halfScreenWidth = MediaQuery.of(context).size.width * 0.5;
    final margin = EdgeInsets.symmetric(horizontal: halfScreenWidth);
    final extraMargin = EdgeInsets.only(
      left: halfScreenWidth,
      right: halfScreenWidth - _extraSectionsPadding,
    );

    final panel = _VisualizationPanelLayout(
      segments: segments,
      margin: extraMargin,
      width: contentWidth,
      recordId: recordId,
      duration: duration,
    );

    final ruler = ChronoRuler(
      key: _timeLineKey,
      margin: extraMargin,
      extraSectionsPadding: _extraSectionsPadding,
      width: contentWidth,
      recordId: recordId,
      duration: duration,
    );

    final bodyLayout = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isSpectrogramMode == true)
          _buildSpectrogram(margin, image!, scale, segments)
        else
          _buildOscillogram(extraMargin, dataSet!, segments),
        panel,
        const SizedBox(height: halfOfLowestIndent),
        ruler,
      ],
    );
    final surface = _Surface(
      isSpectrogramMode: isSpectrogramMode,
      onChangeMode: onChangeMode,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onScaleEnd: onScaleEnd,
      onHorizontalDragDown: onHorizontalDragDown,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      child: bodyLayout,
    );

    final header = _VisualizationCardio(
      hasMurmur: hasMurmur,
      heartRate: heartRate,
      isFine: isFine,
    );

    final surfaceLayout = Padding(
      padding: const EdgeInsets.only(bottom: lowestIndent),
      child: surface,
    );

    return Column(children: [header, Expanded(child: surfaceLayout)]);
  }

  Widget _buildSpectrogram(
    EdgeInsets margin,
    ui.Image image,
    double scale,
    Iterable<SegmentState>? segments,
  ) {
    final spectrogram = SegmentedSpectrogram(
      key: _spectrogramKey,
      margin: margin,
      spectrogramImage: image,
      width: contentWidth,
      segments: segments,
      scale: scale,
      recordId: recordId,
      duration: duration,
    );

    return Expanded(child: spectrogram);
  }

  Widget _buildOscillogram(
    EdgeInsets extraMargin,
    Iterable<double> dataSet,
    Iterable<SegmentState>? segments,
  ) {
    final oscillogram = SegmentedOscillogram(
      key: _oscillogramKey,
      extraSectionsPadding: _extraSectionsPadding,
      margin: extraMargin,
      dataSet: dataSet,
      width: contentWidth,
      segments: segments,
      recordId: recordId,
      duration: duration,
    );
    return Expanded(child: oscillogram);
  }
}

// Keys
const _timeLineKey = Key('time_line_key');
const _spectrogramKey = Key('segmented_spectrogram_key');
const _oscillogramKey = Key('segmented_oscillogram_key');
