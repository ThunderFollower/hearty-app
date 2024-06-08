import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/core.dart';
import '../../../../../examination.dart';
import 'impl/new_record_controller_adapter.dart';
import 'new_record_controller.dart';

/// Provides an instance of [NewRecordController].
final newRecordControllerProvider = Provider.autoDispose<NewRecordController>(
  (ref) => NewRecordControllerAdapter(
    ref.watch(showStethoscopeProvider) as ShowStethoscopeUseCase,
  ),
);
