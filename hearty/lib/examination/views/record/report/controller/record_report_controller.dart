import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../segments/segment_types.dart';
import 'record_report_state.dart';

/// Defines a contract for a controller that handles the actions and state
/// of a record report.
abstract class RecordReportController extends StateNotifier<RecordReportState> {
  RecordReportController(super.state);

  /// Opens the visualization of the record
  void openVisualization();

  /// Opens the related guide for the examination report.
  void openGuide();

  /// Builds a list of record quality segments
  List<Segment> buildQualityList();

  /// computes the record quality percentage
  double computeQualityPercentage();

  /// Builds a list of record segments
  List<Segment> buildSegmentList();

  /// Builds a list of record cardio cycles
  List<CardioCycle> buildCycleList();
}

class Segment {
  Segment({
    this.type,
    required this.start,
    required this.end,
  });

  final SegmentTypes? type;
  final double start;
  final double end;
}

class CardioCycle {
  CardioCycle({
    required this.systole,
    required this.diastole,
  });

  final HalfCardioCycle? systole;
  final HalfCardioCycle? diastole;
}

@protected
class HalfCardioCycle {
  HalfCardioCycle({
    required this.cycle,
    required this.start,
    required this.end,
  });

  final Cycles cycle;
  final double start;
  final double end;
}

@protected
enum Cycles {
  systole,
  diastole,
}
