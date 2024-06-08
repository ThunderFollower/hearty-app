import 'package:auto_route/auto_route.dart';

import '../../../../../examination/examination_controller.dart';
import '../port/action_controller.dart';

class EditExaminationController extends ActionController {
  const EditExaminationController({
    required this.examinationId,
    required this.router,
    required this.routes,
    required this.controller,
  });

  final String examinationId;
  final StackRouter router;
  final List<PageRouteInfo> routes;
  // TODO: we should avoid coupling between controllers
  final ExaminationController controller;

  @override
  void onPressed() {
    controller.init(id: examinationId);
    router.pushAll(routes);
  }
}
