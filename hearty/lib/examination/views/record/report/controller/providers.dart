import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views/router_provider.dart';
import '../../controller/providers.dart';
import '../../visualization/segment/segment.dart';
import 'record_report_controller.dart';
import 'record_report_controller_impl.dart';
import 'record_report_state.dart';

final recordReportStateProvider = StateNotifierProvider.family
    .autoDispose<RecordReportController, RecordReportState, String>(
  (ref, recordId) {
    final provider = recordStateProvider(recordId);
    final nullableSegments =
        ref.watch(provider.select((state) => state.segments));
    final segments = nullableSegments?.toList() ?? <SegmentState>[];
    final hasMurmur =
        ref.watch(provider.select((state) => state.hasMurmur)) ?? false;
    final heartRate =
        ref.watch(provider.select((state) => state.heartRate)) ?? 0;

    final state = RecordReportState(
      hasData: segments.isNotEmpty,
      segments: segments,
      hasMurmur: hasMurmur,
      heartRate: heartRate,
    );

    return RecordReportControllerImpl(
      state,
      router: ref.watch(routerProvider),
      recordId: recordId,
    );
  },
);
