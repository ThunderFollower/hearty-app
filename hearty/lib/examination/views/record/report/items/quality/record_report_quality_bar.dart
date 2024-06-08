part of '../record_report.dart';

class _QualityBar extends StatelessWidget {
  const _QualityBar({
    required this.width,
    required this.qualityList,
  });

  final double width;
  final List<Segment> qualityList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: _qualityBarHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_qualityBarHeight),
        clipBehavior: Clip.hardEdge,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.background,
          child: Row(children: _buildQualityContent()),
        ),
      ),
    );
  }

  List<Widget> _buildQualityContent() => qualityList.map(
        (segment) {
          if (segment.start > _duration) return const SizedBox.shrink();
          return segment.type == SegmentTypes.unsegmentable
              ? _InsufficientQualityPattern(
                  height: _qualityBarHeight,
                  segmentWidth:
                      (segment.end - segment.start) * width / _duration,
                )
              : Container(
                  width: (segment.end - segment.start) * width / _duration,
                  color: Colors.pink.shade500,
                );
        },
      ).toList();
}
