part of '../record_report.dart';

class _Content extends StatelessWidget {
  const _Content({
    required this.width,
    required this.height,
    required this.verticalLayout,
    required this.cycles,
    required this.maxDuration,
  });

  final double width;
  final double height;
  final bool verticalLayout;
  final List<CardioCycle> cycles;
  final double maxDuration;

  @override
  Widget build(BuildContext context) {
    double defaultGap = 1.0;
    double cycleWidth = _cycleDefaultWidth;
    if (cycles.length * _cycleDefaultWidth + cycles.length * defaultGap * 2 >
        width) {
      cycleWidth = (width - cycles.length * defaultGap * 2) / cycles.length;
    } else {
      defaultGap =
          (width - cycles.length * _cycleDefaultWidth) / (cycles.length * 2);
    }
    return Stack(
      children: [
        Container(
          width: width,
          height: height + (verticalLayout ? 7 : 0),
          padding: EdgeInsets.only(bottom: verticalLayout ? 0 : 7),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              _cycleDiagramTimeRulerRowNumber,
              (idx) => Divider(
                color: Colors.blueGrey.shade50,
                thickness: 1.0,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width,
          height: height,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, idx) {
              final systoleHeight =
                  _computeHalfCycleHeight(cycles[idx].systole);
              final diastoleHeight =
                  _computeHalfCycleHeight(cycles[idx].diastole);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultGap),
                    width: cycleWidth,
                    color: AppColors.orangePeel,
                    height: diastoleHeight - 1,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: defaultGap),
                    width: cycleWidth,
                    color: Colors.pink.shade500,
                    height: systoleHeight - 1,
                  ),
                  if (!verticalLayout)
                    _CycleNumber(
                      number: idx,
                      cycleWidth: cycleWidth,
                      defaultGap: defaultGap,
                    ),
                ],
              );
            },
            itemCount: cycles.length,
          ),
        ),
      ],
    );
  }

  double _computeHalfCycleHeight(HalfCardioCycle? halfCardioCycle) {
    final verticalPadding = verticalLayout ? 6 : 20;
    return (height - verticalPadding) *
        ((halfCardioCycle?.end ?? 0) - (halfCardioCycle?.start ?? 0)) /
        maxDuration;
  }
}
