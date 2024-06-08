import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../network/index.dart';
import '../interactors/index.dart';
import '../use_case/index.dart';

/// Provider for the [OpenHelpCenter] command.
final openHelpCenterProvider = Provider.autoDispose<AsyncCommand>(
  (ref) => OpenHelpCenter(Logger(), ref.watch(envUrlProvider)),
);
