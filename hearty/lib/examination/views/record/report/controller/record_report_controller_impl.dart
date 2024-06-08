import 'package:auto_route/auto_route.dart';

import '../../../../../config.dart';
import '../../../../../core/routes/path_resolvers.dart';
import '../../../../segments/segment_types.dart';
import '../../visualization/segment/segment_state.dart';
import 'record_report_controller.dart';

final double duration = Config.signalDuration.inSeconds.toDouble();

class RecordReportControllerImpl extends RecordReportController {
  RecordReportControllerImpl(
    super.state, {
    required this.router,
    required this.recordId,
  });

  final StackRouter router;
  final String recordId;

  List<SegmentState> get filteredSegments => state.segments
      .where((e) => e.type != SegmentTypes.s3 && e.type != SegmentTypes.s4)
      .toList();

  List<SegmentState> get qualitySegments => state.segments
      .where((element) => element.type == SegmentTypes.unsegmentable)
      .toList();

  double _getSafeCoordinate(double coordinate) =>
      coordinate > duration ? duration : coordinate;

  @override
  void openVisualization() {
    final uri = resolveRecordUri(recordId);
    router.pushNamed('$uri');
  }

  @override
  void openGuide() {
    final uri = resolveCapabilitiesGuideUri();
    router.pushNamed('$uri');
  }

  @override
  List<Segment> buildQualityList() {
    final qualityList = <Segment>[];
    final qualitySegmentsLength = qualitySegments.length;
    double leftCoordinate = 0;
    for (int i = 0; i < qualitySegmentsLength; i++) {
      if (leftCoordinate == duration || qualitySegments[i].start >= duration) {
        break;
      }
      final width = qualitySegments[i].start - leftCoordinate;
      if (width > 0) {
        qualityList.add(
          Segment(start: leftCoordinate, end: qualitySegments[i].start),
        );
      }
      final start = _getSafeCoordinate(qualitySegments[i].start);
      final end = _getSafeCoordinate(qualitySegments[i].end);
      qualityList.add(
        Segment(
          start: start,
          end: end,
          type: qualitySegments[i].type,
        ),
      );
      leftCoordinate = end;
    }

    if (qualitySegmentsLength > 0 &&
        qualitySegments[qualitySegmentsLength - 1].end < duration) {
      qualityList.add(
        Segment(
          start: qualitySegments[qualitySegmentsLength - 1].end,
          end: duration,
        ),
      );
    } else if (qualityList.isEmpty) {
      qualityList.add(Segment(start: 0.0, end: duration));
    }

    return qualityList;
  }

  @override
  double computeQualityPercentage() {
    final sum = qualitySegments.fold(
      0.0,
      (acc, segment) {
        if (segment.start >= duration) return acc;
        final end = segment.end > duration ? duration : segment.end;
        return acc + end - segment.start;
      },
    );
    return 100 - (sum * 100 / duration);
  }

  @override
  List<Segment> buildSegmentList() {
    final segmentList = <Segment>[];
    double leftCoordinate = 0;
    final length = filteredSegments.length;
    for (int i = 0; i < length; i++) {
      if (leftCoordinate == duration || filteredSegments[i].start >= duration) {
        break;
      }
      final width = filteredSegments[i].start - leftCoordinate;
      if (width > 0) {
        segmentList.add(
          Segment(start: leftCoordinate, end: filteredSegments[i].start),
        );
      }
      final end = _getSafeCoordinate(filteredSegments[i].end);
      segmentList.add(
        Segment(
          start: filteredSegments[i].start,
          end: end,
          type: filteredSegments[i].type,
        ),
      );
      leftCoordinate = end;
    }

    if (length > 0 && filteredSegments[length - 1].end < duration) {
      segmentList.add(
        Segment(start: filteredSegments[length - 1].end, end: duration),
      );
    }

    return segmentList;
  }

  @override
  List<CardioCycle> buildCycleList() {
    final cycles = <CardioCycle>[];
    final cardioSegments = <HalfCardioCycle>[];
    for (int i = 0; i < filteredSegments.length; i++) {
      if (i + 1 == filteredSegments.length) break;
      if (filteredSegments[i].type == SegmentTypes.s1 &&
          filteredSegments[i + 1].type == SegmentTypes.s2) {
        cardioSegments.add(
          HalfCardioCycle(
            cycle: Cycles.systole,
            start: filteredSegments[i].start,
            end: filteredSegments[i + 1].start,
          ),
        );
      } else if (filteredSegments[i].type == SegmentTypes.s2 &&
          filteredSegments[i + 1].type == SegmentTypes.s1) {
        cardioSegments.add(
          HalfCardioCycle(
            cycle: Cycles.diastole,
            start: filteredSegments[i].start,
            end: filteredSegments[i + 1].start,
          ),
        );
      }
    }

    for (int i = 0; i < cardioSegments.length; i++) {
      final cycle1 = cardioSegments[i];
      if (i + 1 == cardioSegments.length) break;

      final cycle2 = cardioSegments[i + 1];
      if (cycle1.cycle == Cycles.systole &&
          cycle2.cycle == Cycles.diastole &&
          cycle1.end == cycle2.start) {
        cycles.add(CardioCycle(systole: cycle1, diastole: cycle2));
        i = i + 1;
      }
    }
    return cycles;
  }
}
