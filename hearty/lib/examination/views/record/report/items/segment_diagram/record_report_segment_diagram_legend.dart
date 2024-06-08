part of '../record_report.dart';

class _SegmentDiagramLegend extends StatelessWidget {
  const _SegmentDiagramLegend();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.pink.shade500,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: halfOfLowestIndent),
            Text(
              LocaleKeys.s1.tr(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(width: lowestIndent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                color: AppColors.orangePeel,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            const SizedBox(width: halfOfLowestIndent),
            Text(
              LocaleKeys.s2.tr(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(width: lowestIndent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const _InsufficientQualityPattern(height: 16, segmentWidth: 16),
            const SizedBox(width: halfOfLowestIndent),
            Text(
              LocaleKeys.unsegmentable.tr(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
