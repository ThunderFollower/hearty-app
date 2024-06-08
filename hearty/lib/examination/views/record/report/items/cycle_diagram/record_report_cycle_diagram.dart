part of '../record_report.dart';

class _CycleDiagram extends StatelessWidget {
  const _CycleDiagram({
    required this.cycles,
    this.verticalLayout = true,
  });

  final List<CardioCycle> cycles;
  final bool verticalLayout;

  @override
  Widget build(BuildContext context) {
    return _TileContainer(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      hasBorder: verticalLayout,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (verticalLayout) const CycleDiagramLegend(),
          const SizedBox(height: belowLowIndent),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: LayoutBuilder(
              builder: (_, constraints) {
                final screenHeight = MediaQuery.of(context).size.width;
                final height = verticalLayout
                    ? _cycleDiagramVerticalLayoutHeight
                    : screenHeight / _cycleDiagramHeightDividerHorizontalLayout;
                final sideBarWidth = verticalLayout
                    ? _cycleDiagramVerticalLayoutSideBarWidth
                    : _cycleDiagramHorizontalLayoutSideBarWidth;
                final width = constraints.maxWidth - sideBarWidth;
                final maxDuration = _computeMaxDuration();
                return Row(
                  children: [
                    _CycleDiagramTimeRuler(
                      sideBarWidth: sideBarWidth,
                      height: height,
                      verticalLayout: verticalLayout,
                      maxDuration: maxDuration,
                    ),
                    _Content(
                      width: width,
                      height: height,
                      verticalLayout: verticalLayout,
                      cycles: cycles,
                      maxDuration: maxDuration,
                    ),
                  ],
                );
              },
            ),
          ),
          if (!verticalLayout) const SizedBox(height: belowLowIndent),
          if (!verticalLayout) const CycleDiagramLegend(),
        ],
      ),
    );
  }

  double _computeMaxDuration() => cycles.fold(0.0, (previousValue, element) {
        final cycleDuration = (element.systole?.end ?? 0.0) -
            (element.systole?.start ?? 0.0) +
            (element.diastole?.end ?? 0.0) -
            (element.diastole?.start ?? 0.0);
        return math.max(previousValue, cycleDuration);
      });
}
