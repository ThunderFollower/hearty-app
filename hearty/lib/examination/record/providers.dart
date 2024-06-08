import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../utils/utils.dart';
import '../cardio_findings/providers.dart';
import '../examination.dart';
import 'data/providers.dart';
import 'interactors/delete_record_interactor.dart';
import 'interactors/interactors.dart';
import 'record_service_impl.dart';

final determineRecordAnalysisProvider =
    Provider.autoDispose<DetermineRecordAnalysisUseCase>((ref) {
  final interactor = DetermineRecordAnalysisInteractor(
    recordService: ref.watch(recordServiceProvider),
    cardioFindingService: ref.watch(cardioFindingServiceProvider),
    segmentService: ref.watch(segmentServiceProvider),
  );

  ref.delayDispose();
  ref.onDispose(interactor.dispose);

  return interactor;
});

final recordServiceProvider = Provider.autoDispose<RecordService>(
  (ref) {
    // It will delay the disposal of the provider by 1 minute, ensuring that
    // it won't get disposed immediately after it's no longer in use.
    // Instead, it will have a grace period of 1 minute during which it can be
    // reused before it's disposed
    ref.delayDispose(const Duration(minutes: 1));
    final recordService = RecordServiceImpl(
      ref.watch(recordRepositoryProvider),
    );
    ref.onDispose(recordService.dispose);
    return recordService;
  },
);

final saveRecordProvider = Provider.autoDispose<SaveRecordUseCase>(
  (ref) => SaveRecordInteractor(
    ref.watch(assetServiceProvider),
    ref.watch(recordServiceProvider),
  ),
);

final deleteRecordProvider = Provider.autoDispose<DeleteRecordUseCase>((ref) {
  ref.delayDispose();

  final interactor = DeleteRecordInteractor(
    recordService: ref.watch(recordServiceProvider),
    cardioFindingService: ref.watch(cardioFindingServiceProvider),
    examinationService: ref.watch(examinationsServiceProvider),
    logger: Logger(),
  );
  ref.onDispose(interactor.dispose);

  return interactor;
});
