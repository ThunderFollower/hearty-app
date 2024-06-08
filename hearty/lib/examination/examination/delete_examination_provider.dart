import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'delete_examination_use_case.dart';
import 'examination_service.dart';
import 'impl/delete_examination_interactor.dart';

/// Provides a use case deleting an examination by id.
final deleteExaminationProvider =
    Provider.autoDispose<DeleteExaminationUseCase>(
  (ref) => DeleteExaminationInteractor(
    ref.watch(examinationsServiceProvider),
  ),
);
