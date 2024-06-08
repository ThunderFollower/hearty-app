part of '../record_report.dart';

class _TimeRulerWithLegend extends StatelessWidget {
  const _TimeRulerWithLegend();

  @override
  Widget build(BuildContext context) => const Column(
        children: [
          _Ruler(),
          SizedBox(height: highIndent),
          _SegmentDiagramLegend(),
        ],
      );
}

class _Ruler extends StatelessWidget {
  const _Ruler();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildTimeRuler(context),
      ),
    );
  }

  List<Widget> _buildTimeRuler(BuildContext context) {
    return List.generate(
      5,
      (idx) => Column(
        children: [
          SizedBox(
            height: 5,
            child: VerticalDivider(
              thickness: 1.0,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            '${idx * 5}${LocaleKeys.RecordReport_s.tr()}',
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
