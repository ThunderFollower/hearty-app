import 'package:rxdart/rxdart.dart';

import '../../../utils/utils.dart';
import '../../cardio_findings/cardio_finding_service.dart';
import '../../examination.dart';
import '../record_analysis_status.dart';

class DetermineRecordAnalysisInteractor
    with SubscriptionManager
    implements DetermineRecordAnalysisUseCase {
  DetermineRecordAnalysisInteractor({
    required this.recordService,
    required this.cardioFindingService,
    required this.segmentService,
  });

  final RecordService recordService;
  final CardioFindingService cardioFindingService;
  final SegmentService segmentService;

  void dispose() {
    cancelSubscriptions();
  }

  @override
  Stream<RecordAnalysisStatus> execute(
    String examinationId,
    String recordId, [
    Stream? cancellation,
  ]) =>
      _analyzeRecordQualityIfNoneOrRerecord(
        recordId,
        cancellation,
      ).doOnData((event) {
        if (_isAnalysisFinished(event)) {
          _updateExaminationRelations(examinationId);
          _updateSegmentRelations(recordId);
          _updateRecordRelations(recordId);
        }
      }).timeout(_analysisTimeout);

  Stream<RecordAnalysisStatus> _analyzeRecordQualityIfNoneOrRerecord(
    String id,
    Stream? cancellationStream,
  ) async* {
    final stream = recordService.getAnalysisStatus(id, cancellationStream);
    await for (final status in stream) {
      // Run analysis for a new record and rerecording of the existing one.
      if (status == RecordAnalysisStatus.none || _isAnalysisFinished(status)) {
        yield* _analyzeRecordQuality(id, cancellationStream);
        return;
      }
      yield* _retryWhileInvalid(id, cancellationStream);
      return;
    }
  }

  Stream<RecordAnalysisStatus> _analyzeRecordQuality(
    String id,
    Stream? cancellationStream,
  ) async* {
    await _invalidate(id);
    yield* recordService
        .analyse(id, cancellationStream)
        .takeUntil(cancellationStream ?? cancellation)
        .switchMap((_) => _retryWhileInvalid(id, cancellationStream));
  }

  Future<void> _invalidate(String id) => Future.wait([
        segmentService.invalidate(id),
        cardioFindingService.invalidate(id),
        recordService.invalidate(id),
      ]);

  Stream<RecordAnalysisStatus> _retryWhileInvalid(
    String recordId,
    Stream? cancellationStream,
  ) =>
      RetryStream(
        () => _performAnalysisIteration(recordId, cancellationStream),
      );

  Stream<RecordAnalysisStatus> _performAnalysisIteration(
    String recordId,
    Stream? cancellationStream,
  ) =>
      Stream.value(recordId)
          .delay(_analysisDelay)
          .switchMap(
            (value) => recordService.getAnalysisStatus(
              value,
              cancellationStream,
            ),
          )
          .switchMap(_validateStatus);

  Stream<RecordAnalysisStatus> _validateStatus(RecordAnalysisStatus value) {
    if (_isAnalysisFinished(value)) return Stream.value(value);

    final exception = Exception('Retry validation.');
    return Stream.error(exception);
  }

  bool _isAnalysisFinished(RecordAnalysisStatus value) =>
      value == RecordAnalysisStatus.rejected ||
      value == RecordAnalysisStatus.approved ||
      value == RecordAnalysisStatus.failed;

  void _updateExaminationRelations(String examinationId) => cardioFindingService
          .listBy(examinationId: examinationId)
          .take(_amountOfEventsToTake)
          .listen((_) {
        // Nothing to do.
        // The service has been saved the latest state.
      }).addToList(this);

  void _updateRecordRelations(String recordId) => cardioFindingService
          .listBy(recordId: recordId)
          .take(_amountOfEventsToTake)
          .listen((_) {
        // Nothing to do.
        // The service has been saved the latest state.
      }).addToList(this);

  void _updateSegmentRelations(String recordId) => segmentService
          .findByRecordId(recordId)
          .take(_amountOfEventsToTake)
          .listen((_) {
        // Nothing to do.
        // The service has been saved the latest state.
      }).addToList(this);
}

const _analysisDelay = Duration(seconds: 1);
const _analysisTimeout = Duration(minutes: 1);

// This is equal to 2 because it's initially possible to receive data from
// the cache, and then updated data from the API.
const _amountOfEventsToTake = 2;
