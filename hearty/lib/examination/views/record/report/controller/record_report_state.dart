import '../../visualization/segment/segment.dart';

/// Represents the state of a medical examination record.
///
/// This class holds the details and current state of a record, including its
/// metadata, associated data like oscillogram and spectrogram, playback state,
/// and visual properties.
class RecordReportState {
  /// Constructs an instance of [RecordReportState] with the given properties.
  const RecordReportState({
    required this.hasData,
    required this.segments,
    required this.hasMurmur,
    required this.heartRate,
  });

  final bool hasData;
  final List<SegmentState> segments;
  final bool hasMurmur;
  final int heartRate;

  /// Creates a copy of this [RecordReportState] with the given modifications.
  ///
  /// This method allows for modifying a subset of the properties while keeping
  /// others unchanged.
  /// It returns a new instance of [RecordReportState] with the specified changes.
  RecordReportState copyWith({
    bool? hasData,
    List<SegmentState>? segments,
    bool? hasMurmur,
    int? heartRate,
  }) =>
      RecordReportState(
        hasData: hasData ?? this.hasData,
        segments: segments ?? this.segments,
        hasMurmur: hasMurmur ?? this.hasMurmur,
        heartRate: heartRate ?? this.heartRate,
      );
}
