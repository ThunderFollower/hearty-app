part of '../record_report.dart';

class _CycleDiagramTimeRuler extends StatelessWidget {
  const _CycleDiagramTimeRuler({
    required this.sideBarWidth,
    required this.height,
    required this.verticalLayout,
    required this.maxDuration,
  });

  final double sideBarWidth;
  final double height;
  final bool verticalLayout;
  final double maxDuration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sideBarWidth,
      height: height,
      padding: EdgeInsets.only(bottom: verticalLayout ? 2 : 7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_cycleDiagramTimeRulerRowNumber, (idx) {
          final value =
              (maxDuration * idx) / (_cycleDiagramTimeRulerRowNumber - 1);
          return Text(
            value.toStringAsFixed(2),
            style: TextStyle(fontSize: verticalLayout ? 6 : 10),
          );
        }).reversed.toList(),
      ),
    );
  }
}
