import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../app_router.gr.dart';
import '../../../../../../../core/views.dart';
import '../../../../examination/index.dart';
import 'adapter/edit_examination_controller.dart';
import 'port/action_controller.dart';

final editExaminationControllerProvider =
    Provider.autoDispose.family<ActionController, String>((ref, id) {
  final controller = ref.watch(examinationStateProvider.notifier);
  final List<PageRouteInfo> routes = [
    ExaminationRoute(examinationId: id),
    const ExaminationNotesRoute(),
  ];
  return EditExaminationController(
    examinationId: id,
    router: ref.watch(routerProvider),
    routes: routes,
    controller: controller,
  );
});
