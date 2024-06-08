part of '../record_report.dart';

class _SegmentDiagram extends StatelessWidget {
  const _SegmentDiagram({
    required this.segments,
    required this.verticalLayout,
  });

  final List<Segment> segments;
  final bool verticalLayout;

  @override
  Widget build(BuildContext context) {
    return _TileContainer(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      hasBorder: verticalLayout,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (verticalLayout) const _SegmentDiagramLegend(),
          const SizedBox(height: belowLowIndent),
          _SegmentDiagramContent(
            verticalLayout: verticalLayout,
            segments: segments,
          ),
          if (!verticalLayout) const _TimeRulerWithLegend(),
        ],
      ),
    );
  }
}
