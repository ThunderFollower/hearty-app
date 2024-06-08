import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../../../../core/core.dart';
import '../../../../../../../../core/views.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../../cardio_findings/providers.dart';
import '../../../../../../../examination.dart';
import 'examination_tile_controller.dart';
import 'examination_tile_controller_adapter.dart';
import 'examination_tile_state.dart';

final examinationTileStateProvider = StateNotifierProvider.autoDispose
    .family<ExaminationTileController, ExaminationTileState, String>(
  (ref, id) {
    ref.delayDispose();
    return ExaminationTileControllerAdapter(
      const ExaminationTileState(),
      cardioFindingService: ref.watch(cardioFindingServiceProvider),
      examinationId: id,
      logger: Logger(),
      showNotification: ref.watch(showErrorNotificationProvider),
      examinationService: ref.watch(examinationsServiceProvider),
      router: ref.watch(routerProvider),
    );
  },
);
