part of '../record_report.dart';

class _Segment extends StatelessWidget {
  const _Segment({
    required this.segment,
    required this.width,
    required this.height,
    required this.segmentDefaultWidth,
  });

  final Segment segment;
  final double width;
  final double height;
  final double segmentDefaultWidth;

  @override
  Widget build(BuildContext context) {
    final insufficientQualityHeight =
        height * _insufficientQualityHeightQuotient;
    Color color = Colors.white;
    if (segment.type == SegmentTypes.s1) {
      color = Colors.pink.shade500;
    } else if (segment.type == SegmentTypes.s2) {
      color = AppColors.orangePeel;
    }
    final segmentWidth = (segment.end - segment.start) * width / _duration;
    if (segmentWidth <= 0) {
      return const SizedBox.shrink();
    } else if (segment.type == SegmentTypes.unsegmentable) {
      return _InsufficientQualityPattern(
        height: insufficientQualityHeight,
        segmentWidth: segmentWidth,
      );
    } else if (segmentWidth < segmentDefaultWidth) {
      return Container(
        height: height,
        width: segmentWidth,
        color: color,
      );
    } else {
      return Row(
        children: [
          Container(
            height: height,
            width: segmentDefaultWidth,
            color: color,
          ),
          SizedBox(
            height: height,
            width: segmentWidth - segmentDefaultWidth,
          ),
        ],
      );
    }
  }
}
