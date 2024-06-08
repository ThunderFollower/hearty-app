import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../config.dart';
import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/utils.dart';
import '../../examination.dart';
import '../examination_root/examination_list_controller.dart';
import 'examination_state.dart';
import 'utils/point_utils.dart';

class ExaminationController extends StateNotifier<ExaminationState>
    with SubscriptionManager {
  ExaminationController(
    super.state, {
    required this.controller,
    required this.showErrorNotification,
    required this.recordService,
    required this.router,
    required this.logger,
  }) {
    init();

    recordService.deletion.listen((_) {
      refresh();
    }).addToList(this);

    recordService.creation.listen((_) {
      refresh();
    }).addToList(this);
  }

  // TODO: Avoid coupling with another controller.
  final ExaminationListController controller;

  /// A use case for displaying error notifications.
  @protected
  final ShowNotification showErrorNotification;
  @protected
  final RecordService recordService;

  @protected
  final StackRouter router;

  @protected
  final Logger logger;

  StreamSubscription? subscription;

  @override
  void dispose() {
    cancelSubscriptions();
    subscription?.cancel();
    super.dispose();
  }

  Future<void> init({String id = ''}) async {
    state = ExaminationState();
    try {
      final Examination exam;
      if (id.isEmpty) {
        exam = Examination(
          title: LocaleKeys.Examination.tr(),
          createdAt: DateTime.now().toUtc(),
        );
      } else {
        exam = await controller.refreshOneAsStream(id).first;
      }

      state = state.copyWith(
        examination: AsyncData(exam),
        id: id,
        isReceived: exam.from != null,
        bodyPosition: calculateBodyPosition(exam),
      );
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  @protected
  void refresh() {
    subscription?.cancel();
    subscription = controller.refreshOneAsStream(state.id).listen(
      (examination) {
        state = state.copyWith(
          examination: AsyncData(examination),
          bodyPosition: calculateBodyPosition(examination),
        );
      },
      onError: _handleError,
    );
  }

  void _handleError(Object error, StackTrace stackTrace) {
    logger.e('Examination fetching error.', error, stackTrace);
    state = state.copyWith(examination: AsyncError(error, stackTrace));
    showErrorNotification.execute(GenericErrorNotification(error));
  }

  void updateSpot(Spot spot, [BodyPosition? position]) {
    state = state.copyWith(
      bodyPosition: state.bodyPosition,
      bodySide: state.bodySide,
      organType: state.organType,
      spots: state.spots,
    );
    switchSpot(spot, position);
  }

  Future<void> switchSpot(Spot spot, [BodyPosition? position]) async {
    final spots = Map<String, Spot>.from(state.spots);
    spots[pointKey(state.organType, state.bodySide)] = spot;
    state = state.copyWith(spots: spots, bodyPosition: position);
  }

  void switchBodyPosition(BodyPosition position) {
    state = state.copyWith(bodyPosition: position);
  }

  void toggleOrganType() {
    state = state.copyWith(
      bodySide: BodySide.front,
      organType: isHeart ? OrganType.lungs : OrganType.heart,
      bodyPosition: calculateBodyPosition(state.examination.value),
    );
  }

  void toggleLungBodySide() {
    state = state.copyWith(
      bodySide: isFront ? BodySide.back : BodySide.front,
      organType: OrganType.lungs,
      bodyPosition: calculateBodyPosition(state.examination.value),
    );
  }

  @protected
  bool get isFront => state.bodySide == BodySide.front;

  @protected
  bool get isHeart => state.organType == OrganType.heart;

  void openReport(String? examinationId) {
    final uri = resolveExaminationReportUri(examinationId);
    if (router.currentPath != uri.path) router.pushNamed('$uri');
  }

  @protected
  BodyPosition calculateBodyPosition(Examination? examination) {
    if (examination == null) return Config.defaultBodyPosition;
    final examinationPoints = examination.examinationPoints;

    final currentPoint = examinationPoints.singleWhere(
      (element) => element.point.spot == state.currentSpot,
    );

    if (currentPoint.records.isEmpty) return state.bodyPosition;
    return currentPoint.records.first.bodyPosition;
  }
}
