import '../../../../examination.dart';

class SegmentState {
  const SegmentState({
    required this.label,
    required this.start,
    required this.end,
    required this.type,
    this.top,
    this.bottom,
  });

  final String label;
  final double start;
  final double end;
  final SegmentTypes type;
  final int? top;
  final int? bottom;

  SegmentState copyWith({
    String? label,
    double? start,
    double? end,
    SegmentTypes? type,
    int? top,
    int? bottom,
  }) =>
      SegmentState(
        label: label ?? this.label,
        start: start ?? this.start,
        end: end ?? this.end,
        type: type ?? this.type,
        top: top ?? this.top,
        bottom: bottom ?? this.bottom,
      );

  @override
  String toString() {
    return 'SegmentState($label, $type, $start, $end, $top, $bottom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SegmentState &&
            other.runtimeType == runtimeType &&
            label == other.label &&
            start == other.start &&
            end == other.end &&
            type == other.type &&
            top == other.top &&
            bottom == other.bottom);
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, label, start, end, type, top, bottom);
}
