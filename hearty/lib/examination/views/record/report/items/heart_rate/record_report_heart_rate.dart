part of '../record_report.dart';

class _HeartRate extends StatelessWidget {
  const _HeartRate({required this.heartRate});

  final int? heartRate;

  @override
  Widget build(BuildContext context) {
    final header = Text(
      LocaleKeys.RecordReport_Heart_Rate.tr(),
      style: const TextStyle(fontWeight: FontWeight.w500),
    );
    return _TileContainer(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          header,
          _HeartRateContent(heartRate: heartRate),
        ],
      ),
    );
  }
}
