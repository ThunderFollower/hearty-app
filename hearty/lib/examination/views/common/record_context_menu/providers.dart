import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../core/views.dart';
import '../../../../utils/utils.dart';
import '../../../examination.dart';
import 'record_context_menu_controller.dart';
import 'record_context_menu_controller_adapter.dart';

final recordContextMenuControllerProvider =
    Provider.family.autoDispose<RecordContextMenuController, String>(
  (ref, recordId) {
    ref.delayDispose();
    final showStethoscope = ref.watch(showStethoscopeProvider);
    final controller = RecordContextMenuControllerAdapter(
      recordId,
      showStethoscope: showStethoscope as ShowStethoscopeUseCase,
      router: ref.watch(routerProvider),
      recordService: ref.watch(recordServiceProvider),
    );

    ref.onDispose(controller.dispose);
    return controller;
  },
);
