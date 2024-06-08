import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../core/core.dart';
import '../../../../../core/views.dart';
import '../../../../cardio_findings/cardio_findings.dart';
import '../../../../record/index.dart';
import 'record_tile_controller.dart';
import 'record_tile_controller_adapter.dart';
import 'record_tile_state.dart';

final recordTileStateProvider = StateNotifierProvider.autoDispose
    .family<RecordTileController, RecordTileState, String>(
  (ref, recordId) => RecordTileControllerAdapter(
    recordId: recordId,
    recordService: ref.watch(recordServiceProvider),
    cardioFindingService: ref.watch(cardioFindingServiceProvider),
    logger: Logger(),
    showErrorNotification: ref.watch(showErrorNotificationProvider),
    router: ref.watch(routerProvider),
  ),
);
