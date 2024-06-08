import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import '../../received/list/received_list_controller.dart';
import 'adapter/delete_examination_controller.dart';
import 'port/action_controller.dart';

final deleteExaminationControllerProvider =
    Provider.autoDispose.family<ActionController, String>((ref, id) {
  final controller = ref.watch(receivedListStateProvider.notifier);
  return DeleteExaminationController(
    examinationId: id,
    router: ref.watch(routerProvider),
    controller: controller,
  );
});
