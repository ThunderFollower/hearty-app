import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../utils/utils.dart';
import '../../examination/entities/examination.dart';
import '../../examination/entities/examination_point.dart';
import '../../examination/examination_service.dart';
import '../../record/index.dart';
import '../examination_root/sharing/sharing_confirmation/sharing_confirmation.dart';
import '../main_page/content/main_content_key.dart';
import 'examination_report_controller.dart';
import 'examination_report_state.dart';

class ExaminationReportControllerAdapter extends ExaminationReportController
    with SubscriptionManager {
  ExaminationReportControllerAdapter({
    required this.examinationId,
    required this.router,
    required this.examinationService,
    required this.logger,
    required this.showErrorNotification,
  }) : super(_defaultState(examinationId)) {
    _loadExamination();
  }

  @protected
  final String? examinationId;

  @protected
  final ExaminationService examinationService;

  @protected
  final StackRouter router;

  @protected
  final Logger logger;

  /// A use case for displaying error notifications.
  @protected
  final ShowNotification showErrorNotification;

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  static ExaminationReportState _defaultState(String? examinationId) =>
      ExaminationReportState(recordIds: examinationId == null ? [] : null);

  void _loadExamination() {
    final id = examinationId;
    if (id == null) return;
    examinationService
        .findOne(id, cancellation)
        .map((examination) => examination.examinationPoints)
        .map((points) => points.where(_isHeartPoint))
        .doOnData(_updateAmountHeartSpotsState)
        .map((points) => points.toList()..sort(_compareSpotNumber))
        .map((points) => points.expand(_takeRecordIds))
        .listen(_handleRecordIds, onError: _handleError)
        .addToList(this);
  }

  void _updateAmountHeartSpotsState(Iterable<ExaminationPoint> points) {
    state = state.copyWith(amountOfHeartSpots: points.length);
  }

  void _handleRecordIds(Iterable<String> recordIds) {
    state = state.copyWith(
      recordIds: recordIds,
      recordsAmount: recordIds.length,
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    logger.e('Failed to fetch report data.', error, stackTrace);
    showErrorNotification.execute(GenericErrorNotification(error));
  }

  int _compareSpotNumber(ExaminationPoint previous, ExaminationPoint next) =>
      previous.point.spot.number.compareTo(next.point.spot.number);

  bool _isHeartPoint(ExaminationPoint point) =>
      point.point.type == OrganType.heart;

  Iterable<String> _takeRecordIds(ExaminationPoint point) =>
      point.records.map(_mapToId);

  String _mapToId(Record record) => record.id!;

  @override
  void dismiss() {
    final currentUri = resolveExaminationReportUri(examinationId);
    router.popUntilRouteWithPath('$currentUri');

    if (router.canPop()) router.pop();
  }

  @override
  void openGuide() {
    final currentUri = resolveExaminationReportUri(examinationId);
    router.popUntilRouteWithPath('$currentUri');

    if (router.currentPath == currentUri.path) {
      final uri = resolveCapabilitiesGuideUri();
      router.pushNamed('$uri');
    }
  }

  @override
  void share() {
    final id = examinationId;
    if (id == null) return;
    examinationService
        .findOne(id, cancellation)
        .takeWhile((_) => mounted)
        .take(1)
        .listen(_handleSharing)
        .addToList(this);
  }

  void _handleSharing(Examination examination) {
    final context = mainContentKey.currentContext;
    final id = examinationId;
    if (context == null || id == null) return;

    final dialog = SharingConfirmation(
      examinationId: id,
      isReceivedExamination: isReceived(examination),
    );

    showModalDialog<bool>(context: context, child: dialog);
  }

  bool isReceived(Examination examination) => examination.from != null;
}
