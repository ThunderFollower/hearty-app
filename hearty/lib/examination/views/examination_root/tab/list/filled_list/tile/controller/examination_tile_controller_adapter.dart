import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../../../../../../../core/core.dart';
import '../../../../../../../../core/views/notifications/generic_error_notification.dart';
import '../../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../../utils/utils.dart';
import '../../../../../../../cardio_findings/cardio_finding.dart';
import '../../../../../../../cardio_findings/cardio_finding_service.dart';
import '../../../../../../../examination/entities/examination.dart';
import '../../../../../../../examination/entities/examination_point.dart';
import '../../../../../../../examination/examination_service.dart';
import '../../../../../../../exceptions/index.dart';
import '../../../../../../../record/entities/record.dart';
import '../../../../../../../record/organ_type.dart';

import 'examination_tile_controller.dart';

typedef FindingAsset = Tuple2<String, String>;

class ExaminationTileControllerAdapter extends ExaminationTileController
    with SubscriptionManager {
  ExaminationTileControllerAdapter(
    super.state, {
    required this.cardioFindingService,
    required this.examinationService,
    required this.examinationId,
    required this.logger,
    required this.showNotification,
    required this.router,
  }) {
    loadExamination();
    loadCardio();
  }

  final String examinationId;
  final CardioFindingService cardioFindingService;
  final ExaminationService examinationService;
  final Logger logger;
  final ShowNotification showNotification;
  final StackRouter router;

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  void handleTap() {
    final uri = resolveExaminationDetailUri(examinationId);
    if (router.currentPath != uri.path) router.pushNamed('$uri');
  }

  @protected
  void loadExamination() {
    examinationService
        .findOne(examinationId, cancellation)
        .ignoreError(UnauthorizedException)
        .switchIfEmpty(Stream.error(const ExaminationNotFoundException()))
        .doOnData(_handleExamination)
        .map((examination) => examination.examinationPoints)
        .listen(_handleExaminationPoints, onError: _handleError)
        .addToList(this);
  }

  @protected
  void loadCardio() {
    cardioFindingService
        .listBy(examinationId: examinationId, cancellation: cancellation)
        .ignoreError(UnauthorizedException)
        .ignoreError(NotFoundException)
        .doOnData(_handleCardioFindings)
        .where((event) => event.isNotEmpty)
        .map(_mapCardioFindingsToFindingAsset)
        .listen(_handleFindingAsset, onError: _handleError)
        .addToList(this);
  }

  void _handleCardioFindings(Iterable<CardioFinding> cardioFindings) {
    const data = '';
    state = state.copyWith(iconPath: data, priorFinding: data);
  }

  FindingAsset _mapCardioFindingsToFindingAsset(
    Iterable<CardioFinding> cardioFindings,
  ) {
    final hasMurmur = cardioFindings.any((element) => element.hasMurmur);
    final hasLowQuality = cardioFindings.any((element) => !element.isFine);
    if (hasMurmur) {
      return FindingAsset(
        LocaleKeys.Murmur_detected.tr(),
        _redAttentionIconPath,
      );
    } else if (hasLowQuality) {
      return FindingAsset(
        LocaleKeys.InsufficientQuality_regularName.tr(),
        _warningIconPath,
      );
    }
    return FindingAsset(
      LocaleKeys.Murmur_not_detected.tr(),
      _neutralAttentionIconPath,
    );
  }

  void _handleFindingAsset(FindingAsset findingsData) {
    state = state.copyWith(
      priorFinding: findingsData.item1,
      iconPath: findingsData.item2,
    );
  }

  void _handleExamination(Examination examination) {
    state = state.copyWith(
      title: examination.title,
      modificationDate: _getModificationDateString(examination),
      from: examination.from,
    );
  }

  void _handleExaminationPoints(List<ExaminationPoint> points) {
    final heartSpotsAmount = points.where(_isHeartPoint).length;
    final lungSpotsAmount = points.length - heartSpotsAmount;

    state = state.copyWith(
      amountOfHeartRecords: _countRecordsByType(points, OrganType.heart),
      amountOfLungRecords: _countRecordsByType(points, OrganType.lungs),
      amountOfHeartSpots: heartSpotsAmount,
      amountOfLungSpots: lungSpotsAmount,
    );
  }

  bool _isHeartPoint(ExaminationPoint point) =>
      point.point.type == OrganType.heart;

  void _handleError(Object error, StackTrace stackTrace) {
    logger.e('$this: Failed to fetch data.', error, stackTrace);
    showNotification.execute(const GenericErrorNotification());
  }

  String _getModificationDateString(Examination examination) =>
      DateFormat.yMMMd().add_jm().format(examination.modifiedAt!.toLocal());

  int _countRecordsByType(List<ExaminationPoint> points, OrganType type) =>
      points
          .where((examinationPoint) => examinationPoint.point.type == type)
          .map(_mapToAmountOfRecordsOnEachPoint)
          // Can't be more than 1 record per 1 spot presented
          .fold(0, _getRecordsAmount);

  int _mapToAmountOfRecordsOnEachPoint(ExaminationPoint point) =>
      point.records.where((Record record) => record.asset != null).length;

  int _getRecordsAmount(int previousValue, int nextValue) =>
      previousValue + nextValue;
}

const _neutralAttentionIconPath = 'assets/images/neutral_attention.svg';
const _redAttentionIconPath = 'assets/images/red_attention.svg';
const _warningIconPath = 'assets/images/attention.svg';
