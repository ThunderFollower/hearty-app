import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'updater_controller.dart';
import 'updater_controller_adapter.dart';

/// Provides an auto-disposable instance of [UpdaterController].
final updaterControllerProvider = Provider.autoDispose<UpdaterController>(
  (ref) => UpdaterControllerAdapter(
    logger: Logger(),
  ),
);
