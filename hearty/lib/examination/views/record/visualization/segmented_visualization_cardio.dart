part of 'segmented_visualization.dart';

class _VisualizationCardio extends StatelessWidget {
  const _VisualizationCardio({
    this.hasMurmur,
    this.heartRate,
    this.isFine,
  });

  /// Indicates if the record has a murmur.
  final bool? hasMurmur;

  /// The heart rate associated with this record.
  final int? heartRate;

  /// Indicates if the record is fine.
  final bool? isFine;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        FindingLabelWidget(hasMurmur: hasMurmur, isFine: isFine),
        const Spacer(flex: 8),
        if (_shouldShowHeartRate())
          HeartRateWidget(key: _heartRateKey, value: heartRate!),
        const Spacer(),
      ],
    );
  }

  bool _shouldShowHeartRate() => heartRate != null && heartRate! > 0;
}

// Keys
const _heartRateKey = Key('heart_rate_key');
