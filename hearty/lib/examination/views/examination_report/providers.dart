import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../utils/utils.dart';
import '../../examination.dart';
import 'examination_report_controller.dart';
import 'examination_report_controller_adapter.dart';
import 'examination_report_state.dart';

final examinationReportStateProvider = StateNotifierProvider.autoDispose
    .family<ExaminationReportController, ExaminationReportState, String?>(
  (ref, examinationId) {
    // It will delay the disposal of the provider by 5 seconds, ensuring that
    // it won't get disposed immediately after it's no longer in use.
    // Instead, it will have a grace period of 1 minute during which it can be
    // reused before it's disposed
    ref.delayDispose();
    return ExaminationReportControllerAdapter(
      examinationId: examinationId,
      router: ref.watch(routerProvider),
      examinationService: ref.watch(examinationsServiceProvider),
      logger: Logger(),
      showErrorNotification: ref.watch(showErrorNotificationProvider),
    );
  },
);
