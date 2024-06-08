import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app_router.gr.dart';
import '../../../../../core/views.dart';
import '../../../../examination/index.dart';
import '../examination_body_controller.dart';
import '../examination_body_controller_adapter.dart';

final examinationBodyControllerProvider =
    Provider.autoDispose.family<ExaminationBodyController, String?>(
  (ref, id) => ExaminationBodyControllerAdapter(
    ref.watch(routerProvider),
    ref.watch(deleteExaminationProvider),
    ref.watch(mainRouteProvider).routeName,
    const ExaminationNotesRoute(),
    id,
  ),
);
