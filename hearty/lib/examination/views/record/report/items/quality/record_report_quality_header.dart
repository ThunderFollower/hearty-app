part of '../record_report.dart';

class _Header extends StatelessWidget {
  const _Header({required this.percent});

  final String percent;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .labelMedium
        ?.copyWith(color: Colors.pink.shade500);
    return RichText(
      text: TextSpan(
        text: '${percent == '100.0' ? '100' : percent}% ',
        style: textStyle?.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        children: [
          TextSpan(
            text: LocaleKeys.RecordReport_Recording_quality.tr(),
            style: textStyle?.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.grey.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
