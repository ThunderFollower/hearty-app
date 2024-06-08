import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../../utils/utils.dart';
import '../../../../../examination/index.dart';
import 'adapter/share_button_controller.dart';
import 'port/action_controller.dart';

/// Defines a controller for a [SharedButton] for a specific examination [id].
final shareButtonControllerProvider =
    Provider.autoDispose.family<ActionController, String>((ref, id) {
  ref.delayDispose();
  final controller = ShareButtonController(
    examinationId: id,
    examinationService: ref.watch(examinationsServiceProvider),
    logger: Logger(),
  );
  ref.onDispose(controller.dispose);
  return controller;
});
