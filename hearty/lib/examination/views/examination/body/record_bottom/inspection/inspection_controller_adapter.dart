import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/views.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../cardio_findings/cardio_finding_service.dart';
import '../../../../../examination.dart';
import '../../../../../record/record_analysis_status.dart';
import 'inspection_controller.dart';

class InspectionControllerAdapter extends InspectionController
    with SubscriptionManager {
  InspectionControllerAdapter(
    super.state,
    this.recordId, {
    required this.recordService,
    required this.cardioFindingService,
    required this.logger,
    required this.showErrorNotification,
    required this.router,
    required this.showStethoscope,
    required this.deleteRecord,
    required this.mutable,
  }) {
    _loadRecord();
    _loadCardioList();
  }

  @protected
  final String recordId;

  @protected
  final RecordService recordService;

  @protected
  final CardioFindingService cardioFindingService;

  @protected
  final StackRouter router;

  @protected
  final Logger logger;

  /// A use case for displaying error notifications.
  @protected
  final ShowNotification showErrorNotification;

  @protected
  final ShowStethoscopeUseCase showStethoscope;

  @protected
  final DeleteRecordUseCase deleteRecord;

  @protected
  final bool mutable;

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  void _loadRecord() {
    recordService
        .findOne(recordId, cancellation)
        .ignoreError(UnauthorizedException)
        .ignoreError(NotFoundException)
        .doOnData(_handleRecordWithoutAnalysis)
        .listen(_handleRecord, onError: _handleError)
        .addToList(this);
  }

  void _handleRecordWithoutAnalysis(Record record) {
    if (state.isFine != null) return;

    final organ = record.spot?.organ;
    final isFine = record.analysisStatus == RecordAnalysisStatus.none ||
        organ == OrganType.lungs;

    state = state.copyWith(isFine: isFine ? true : null);
  }

  void _handleRecord(Record record) {
    final organ = record.spot?.organ;
    state = state.copyWith(
      createdAt: record.asset?.createdAt,
      organ: organ,
      spot: record.spot,
      name: record.bodyPosition.name.tr(),
      timestamp: record.asset?.createdAt.toLocal(),
      examinationId: record.examinationId,
    );
  }

  void _loadCardioList() {
    cardioFindingService
        .listBy(
          recordId: recordId,
          cancellation: cancellation,
        )
        .ignoreError(NotFoundException)
        .ignoreError(UnauthorizedException)
        .listen(_handleCardioList, onError: _handleError)
        .addToList(this);
  }

  void _handleCardioList(Iterable<CardioFinding> cardioList) {
    final cardio = cardioList.isNotEmpty == true ? cardioList.first : null;

    state = state.copyWith(
      heartRate: cardio?.heartRate != 0 ? cardio?.heartRate : null,
      isFine: cardio?.isFine,
      hasMurmur: cardio?.hasMurmur,
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    logger.e('Failed to fetch inspection data.', error, stackTrace);
    showErrorNotification.execute(GenericErrorNotification(error));
  }

  @override
  void play() {
    final uri = resolveRecordUri(recordId, mutable: mutable);

    if (router.currentPath == uri.path) return;

    router
        .pushNamed<void>(uri.toString())
        .catchError((error) => _handleNavigationError(error, uri));
  }

  void _handleNavigationError(dynamic error, Uri uri) {
    logger.e("$this couldn't navigate to the $uri route.", error);
  }

  void _openInsufficientQualityRoute() {
    final uri = resolveInsufficientQualityUri(recordId);
    if (router.currentPath != uri.path) {
      router.pushNamed<void>('$uri').catchError(
            (error) => _handleNavigationError(error, uri),
          );
    }
  }

  @override
  void openReport() => recordService
      .findOne(recordId, cancellation)
      .takeWhile((_) => mounted)
      .take(_amountOfEventsToTake)
      .where((_) => state.isFine != null)
      .listen(_handleReportOpening, onError: _handleError)
      .addToList(this);

  void _handleReportOpening(Record record) {
    final organ = record.spot?.organ;
    if (record.analysisStatus == RecordAnalysisStatus.none ||
        organ == OrganType.lungs) {
      // Do nothing for the record without analysis.
      return;
    }

    if (state.isFine == false) return _openInsufficientQualityRoute();

    _openReport(record);
  }

  void _openReport(Record record) {
    final uri = resolveRecordReportUri(
      recordId,
      spotNumber: record.spot?.number ?? 0,
      spotName: record.spot?.name.tr() ?? '',
      bodyPosition: record.bodyPosition.name.tr(),
    );

    if (router.currentPath != uri.path) {
      router
          .pushNamed<void>('$uri')
          .catchError((error) => _handleNavigationError(error, uri));
    }
  }

  @override
  Future<void> delete() async {
    try {
      await deleteRecord.execute(recordId, cancellation);
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  @override
  Future<void> recordAgain() async {
    try {
      await showStethoscope.execute(
        mode: StethoscopeMode.recording,
        recordId: recordId,
      );
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }
}

// This is equal to 2 because it's initially possible to receive data from
// the cache, and then updated data from the API.
const _amountOfEventsToTake = 2;
