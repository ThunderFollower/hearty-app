import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../core/views.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../cardio_findings/providers.dart';
import '../../../../../../examination.dart';
import '../inspection_controller.dart';
import '../inspection_controller_adapter.dart';
import '../inspection_state.dart';

typedef InspectionParameters = Tuple2<String, bool>;

final inspectionControllerProvider = StateNotifierProvider.autoDispose
    .family<InspectionController, InspectionState, InspectionParameters>(
        (ref, params) {
  // It will delay the disposal of the provider by 5 seconds, ensuring that
  // it won't get disposed immediately after it's no longer in use.
  // Instead, it will have a grace period of 5 second during which it can be
  // reused before it's disposed
  ref.delayDispose();

  final showStethoscope = ref.watch(showStethoscopeProvider);
  return InspectionControllerAdapter(
    const InspectionState(),
    params.item1,
    recordService: ref.watch(recordServiceProvider),
    cardioFindingService: ref.watch(cardioFindingServiceProvider),
    logger: Logger(),
    showErrorNotification: ref.watch(showErrorNotificationProvider),
    router: ref.watch(routerProvider),
    showStethoscope: showStethoscope as ShowStethoscopeUseCase,
    deleteRecord: ref.watch(deleteRecordProvider),
    mutable: params.item2,
  );
});
