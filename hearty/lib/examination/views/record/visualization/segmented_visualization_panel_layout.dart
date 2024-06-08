part of 'segmented_visualization.dart';

class _VisualizationPanelLayout extends StatelessWidget {
  const _VisualizationPanelLayout({
    this.segments,
    required this.margin,
    required this.width,
    required this.recordId,
    required this.duration,
  });

  final Iterable<SegmentState>? segments;
  final EdgeInsets margin;
  final double width;

  /// Identifier for the associated audio record.
  final String recordId;

  /// Represents the total duration of the audio.
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final list = segments?.map(_mapTimeToPixelSegment);
    if (list == null) return const SizedBox.shrink();

    return Column(
      children: [
        const SizedBox(height: _segmentationPanelSpacerHeight),
        SegmentationPanel(
          width: width,
          segments: list,
          margin: margin,
          padding: _extraSectionsPadding,
          recordId: recordId,
        ),
      ],
    );
  }

  SegmentState _mapTimeToPixelSegment(SegmentState segment) => segment.copyWith(
        start: _convertTimeToPixel(segment.start),
        end: _convertTimeToPixel(segment.end),
      );

  double _convertTimeToPixel(double time) {
    final seconds = duration.inSeconds;
    final step = width / seconds;
    final normalizedTime = min(seconds, time);
    return normalizedTime * step;
  }
}
