import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import '../../../core/views/router_provider.dart';
import '../../../utils/utils.dart';
import '../../record/index.dart';
import '../examination_root/examination_list_controller.dart';
import 'examination_controller.dart';
import 'examination_state.dart';

/// Inits an empty `Examination` when calling the constructor
final examinationStateProvider =
    StateNotifierProvider.autoDispose<ExaminationController, ExaminationState>(
  (ref) {
    // It will delay the disposal of the provider by 5 seconds, ensuring that
    // it won't get disposed immediately after it's no longer in use.
    // Instead, it will have a grace period of 1 minute during which it can be
    // reused before it's disposed
    ref.delayDispose();
    return ExaminationController(
      ExaminationState(),
      controller: ref.watch(examinationListController.notifier),
      showErrorNotification: ref.watch(showErrorNotificationProvider),
      recordService: ref.watch(recordServiceProvider),
      router: ref.watch(routerProvider),
      logger: Logger(),
    );
  },
);
