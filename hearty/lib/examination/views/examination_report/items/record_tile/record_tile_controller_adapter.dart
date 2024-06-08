import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';

import '../../../../../core/core.dart';
import '../../../../../core/views/notifications/generic_error_notification.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../utils/utils.dart';
import '../../../../cardio_findings/cardio_finding.dart';
import '../../../../cardio_findings/cardio_finding_service.dart';
import '../../../../record/index.dart';
import 'record_tile_controller.dart';
import 'record_tile_state.dart';

typedef FindingAsset = Tuple2<String, String>;

class RecordTileControllerAdapter extends RecordTileController
    with SubscriptionManager {
  RecordTileControllerAdapter({
    required this.recordId,
    required this.recordService,
    required this.cardioFindingService,
    required this.logger,
    required this.router,
    required this.showErrorNotification,
  }) : super(const RecordTileState()) {
    _loadRecord();
    _loadCardio();
  }

  final String recordId;
  final RecordService recordService;
  final CardioFindingService cardioFindingService;
  final StackRouter router;
  final Logger logger;

  /// A use case for displaying error notifications.
  final ShowNotification showErrorNotification;

  void _loadRecord() {
    recordService
        .findOne(recordId, cancellation)
        .listen(_handleFoundRecord, onError: _onError)
        .addToList(this);
  }

  void _handleFoundRecord(Record record) {
    state = state.copyWith(
      createdAt: record.asset?.createdAt,
      spotName: record.spot?.name.tr(),
      spotNumber: record.spot?.number,
      bodyPositionName: record.bodyPosition.name.tr(),
    );
  }

  void _loadCardio() {
    cardioFindingService
        .listBy(recordId: recordId, cancellation: cancellation)
        .ignoreError(NotFoundException)
        .ignoreError(UnauthorizedException)
        .flatMap((value) => Stream.fromIterable(value))
        .doOnData(_handleFoundCardio)
        .map(_takeFindings)
        .listen(_handleFindingAsset, onError: _onError)
        .addToList(this);
  }

  void _handleFoundCardio(CardioFinding cardio) {
    state = state.copyWith(
      heartRate: cardio.heartRate,
    );
  }

  void _handleFindingAsset(FindingAsset findingsData) {
    state = state.copyWith(
      finding: findingsData.item1,
      assetPath: findingsData.item2,
    );
  }

  FindingAsset _takeFindings(CardioFinding finding) {
    if (finding.hasMurmur) {
      return FindingAsset(
        LocaleKeys.Murmur_detected.tr(),
        _redAttentionIconPath,
      );
    } else if (!finding.isFine) {
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

  void _onError(Object error, StackTrace stackTrace) {
    logger.e('Failed to fetch record data.', error, stackTrace);
    final errorMessage = LocaleKeys.Something_went_wrong.tr();
    state.copyWith(error: errorMessage);
    showErrorNotification.execute(GenericErrorNotification(error));
  }

  void _openInsufficientQualityRoute() {
    final uri = resolveInsufficientQualityUri(recordId);
    if (router.currentPath != uri.path) router.pushNamed('$uri');
  }

  @override
  void openRecordReport() {
    if (state.error != null) return;
    if (state.heartRate == 0) {
      _openInsufficientQualityRoute();
      return;
    }
    final uri = resolveRecordReportUri(
      recordId,
      spotNumber: state.spotNumber ?? 0,
      spotName: state.spotName ?? '',
      bodyPosition: state.bodyPositionName ?? '',
    );
    router.pushNamed('$uri');
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }
}

const _neutralAttentionIconPath = 'assets/images/neutral_attention.svg';
const _redAttentionIconPath = 'assets/images/red_attention.svg';
const _warningIconPath = 'assets/images/attention.svg';
