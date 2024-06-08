part of 'segmentation_panel.dart';

class _Content extends StatelessWidget {
  const _Content({
    required this.width,
    required this.padding,
    this.segments,
  });

  final double width;
  final double padding;
  final Iterable<SegmentState>? segments;

  @override
  Widget build(BuildContext context) {
    final data = segments;

    return data != null && data.isNotEmpty
        ? _buildContent(data)
        : const SizedBox.shrink();
  }

  Widget _buildContent(Iterable<SegmentState> data) => Stack(
        children: [
          _Background(width: width, padding: padding),
          ..._buildSegmentMarks(data),
        ],
      );

  Iterable<Widget> _buildSegmentMarks(Iterable<SegmentState> segments) =>
      segments.map(
        (element) => SegmentationPanelLabel(
          key: Key(element.toString()),
          label: element.label,
          type: element.type,
          start: element.start,
          end: element.end,
        ),
      );
}
