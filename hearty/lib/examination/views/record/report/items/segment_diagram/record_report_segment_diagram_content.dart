part of '../record_report.dart';

class _SegmentDiagramContent extends StatelessWidget {
  const _SegmentDiagramContent({
    required this.verticalLayout,
    required this.segments,
  });

  final bool verticalLayout;
  final List<Segment> segments;

  @override
  Widget build(BuildContext context) {
    final segmentDefaultWidth = verticalLayout
        ? _segmentDefaultWidthVerticalLayout
        : _segmentDefaultWidthHorizontalLayout;
    final screenHeight = MediaQuery.of(context).size.width;
    final height = verticalLayout
        ? _segmentHeightVerticalLayout
        : screenHeight / _segmentHeightDividerHorizontalLayout;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 11.0),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildContent(width, height, segmentDefaultWidth),
          );
        },
      ),
    );
  }

  List<Widget> _buildContent(
    double width,
    double height,
    double segmentDefaultWidth,
  ) {
    return segments
        .map(
          (segment) => _Segment(
            segment: segment,
            width: width,
            height: height,
            segmentDefaultWidth: segmentDefaultWidth,
          ),
        )
        .toList();
  }
}
