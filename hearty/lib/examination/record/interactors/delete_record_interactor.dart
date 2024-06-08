import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

import '../../../utils/utils.dart';
import '../../cardio_findings/cardio_finding_service.dart';
import '../../examination.dart';

class DeleteRecordInteractor
    with SubscriptionManager
    implements DeleteRecordUseCase {
  DeleteRecordInteractor({
    required this.recordService,
    required this.cardioFindingService,
    required this.examinationService,
    required this.logger,
  });

  @protected
  final RecordService recordService;
  @protected
  final CardioFindingService cardioFindingService;
  @protected
  final ExaminationService examinationService;
  @protected
  final Logger logger;

  void dispose() {
    cancelSubscriptions();
  }

  @override
  Future<void> execute(String id, [Stream? cancellation]) {
    final completer = Completer<void>();

    recordService.findOne(id).take(1).listen(
      (record) async {
        await _handleRecord(id, cancellation, record);
        completer.complete();
      },
      onError: (Object error, StackTrace stackTrace) {
        _handleRecordError(error, stackTrace);
        completer.completeError(error, stackTrace);
      },
    ).addToList(this);

    return completer.future;
  }

  void _handleRecordError(Object error, StackTrace stackTrace) {
    logger.e('$this could not find a record.', error, stackTrace);
  }

  Future<void> _handleRecord(
    String id,
    Stream<dynamic>? cancellation,
    Record record,
  ) async {
    await recordService.delete(id, cancellation);

    final examinationId = record.examinationId;
    if (examinationId != null) {
      await _updateExamination(examinationId);
      _updateExaminationRelations(examinationId);
    }

    _updateRecordRelations(id);
  }

  Future<void> _updateExamination(String examinationId) {
    final completer = Completer<void>();

    examinationService.findOne(examinationId).take(1).listen(
      (examination) async {
        await _handleExamination(examination);
        completer.complete();
      },
      onError: (Object error, StackTrace stackTrace) {
        _handleRecordError(error, stackTrace);
        completer.completeError(error, stackTrace);
      },
    ).addToList(this);

    return completer.future;
  }

  Future<void> _handleExamination(Examination examination) async {
    final updatedExamination = examination.copyWith(
      modifiedAt: DateTime.now().toUtc(),
    );
    await examinationService.save(updatedExamination);
  }

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
}

// This is equal to 2 because it's initially possible to receive data from
// the cache, and then updated data from the API.
const _amountOfEventsToTake = 2;
