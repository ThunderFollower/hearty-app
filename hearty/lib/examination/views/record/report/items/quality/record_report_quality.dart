part of '../record_report.dart';

class _Quality extends StatelessWidget {
  const _Quality({
    required this.qualityList,
    required this.qualityPercent,
  });

  final List<Segment> qualityList;
  final double qualityPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      child: LayoutBuilder(
        builder: (_, constraints) {
          final width = constraints.maxWidth;
          final percent = qualityPercent.toStringAsFixed(1);
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Header(percent: percent),
              const SizedBox(height: belowLowIndent),
              _QualityBar(width: width, qualityList: qualityList),
            ],
          );
        },
      ),
    );
  }
}
