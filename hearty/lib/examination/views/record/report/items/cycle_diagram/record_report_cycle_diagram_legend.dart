part of '../record_report.dart';

class CycleDiagramLegend extends StatelessWidget {
  const CycleDiagramLegend({
    super.key,
  });

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
              LocaleKeys.RecordReport_Systole.tr(),
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
              LocaleKeys.RecordReport_Diastole.tr(),
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
