part of '../record_report.dart';

class _HeartRateContent extends StatelessWidget {
  const _HeartRateContent({required this.heartRate});

  final int? heartRate;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.pink.shade500,
          fontSize: 30,
        );
    final heartIcon = Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: LocalImage(
        assetPath: _heartRateIconPath,
        color: Colors.pink.shade500,
        width: 12,
        height: 12,
      ),
    );
    final description = TextSpan(
      text: ' ${LocaleKeys.RecordReport_bpm.tr()}',
      style: textStyle?.copyWith(fontSize: 14),
    );
    final rate = RichText(
      text: TextSpan(
        text: '${heartRate ?? ''}',
        style: textStyle,
        children: [
          description,
        ],
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        heartIcon,
        const SizedBox(width: halfOfLowestIndent),
        rate,
      ],
    );
  }
}
