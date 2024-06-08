part of 'record_controller_impl.dart';

mixin _Segments on _Base {
  void _loadSegments() {
    segmentService
        .findByRecordId(recordId, cancellation)
        .listen(_handleFoundSegments, onError: _handleError)
        .addToList(this);
  }

  void _handleFoundSegments(Iterable<Segment> segments) {
    final ordered = segments
        .where(_filterSegmentBeforeDuration)
        .map(_mapSegmentToSegmentState)
        .toList()
      ..sort(_orderSegmentStatesAscending);
    state = state.copyWith(segments: ordered);
  }

  static int _orderSegmentStatesAscending(SegmentState a, SegmentState b) =>
      a.start.compareTo(b.start);

  static bool _filterSegmentBeforeDuration(Segment segment) =>
      segment.start < duration;

  static SegmentState _mapSegmentToSegmentState(Segment segment) {
    return SegmentState(
      label: segment.type.name.tr(),
      start: segment.start,
      end: segment.end,
      type: segment.type,
      top: segment.top,
      bottom: segment.bottom,
    );
  }
}
