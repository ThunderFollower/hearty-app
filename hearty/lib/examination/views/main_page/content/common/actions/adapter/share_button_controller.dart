import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../../core/views/show_modal_dialog.dart';
import '../../../../../../../utils/utils.dart';
import '../../../../../../examination/index.dart';
import '../../../../../examination_root/sharing/empty_records_alert/empty_records_alert.dart';
import '../../../../../examination_root/sharing/sharing_confirmation/sharing_confirmation.dart';
import '../../../main_content_key.dart';
import '../port/action_controller.dart';

const _fetchingTimeout = Duration(seconds: 2);

/// Deals with system events related with the `ShareButton`.
class ShareButtonController extends ActionController with SubscriptionManager {
  ShareButtonController({
    required this.examinationId,
    required this.examinationService,
    required this.logger,
  });

  final String examinationId;

  @protected
  final ExaminationService examinationService;

  @protected
  final Logger logger;

  void dispose() {
    cancelSubscriptions();
  }

  @override
  void onPressed() {
    examinationService
        .findOne(examinationId, cancellation)
        .takeUntil(TimerStream(null, _fetchingTimeout))
        .take(1)
        .map(buildDialog)
        .listen(handleWidget, onError: handleError)
        .addToList(this);
  }

  @protected
  @visibleForTesting
  void handleWidget(Widget widget) {
    final context = mainContentKey.currentContext;
    if (context == null) return;

    showModalDialog<bool>(
      context: context,
      child: widget,
    );
  }

  @protected
  @visibleForTesting
  void handleError(Object error, StackTrace stackTrace) {
    logger.e('$this', error, stackTrace);
  }

  /// Builds either a [SharingConfirmation] if we can share the [examination]
  /// or an [EmptyRecordsAlert] if we can't.
  @protected
  @visibleForTesting
  Widget buildDialog(Examination examination) {
    final isSharingAvailable = canShare(examination);
    final isReceivedExamination = isReceived(examination);
    if (isSharingAvailable) {
      return SharingConfirmation(
        examinationId: examinationId,
        isReceivedExamination: isReceivedExamination,
      );
    }
    return const EmptyRecordsAlert();
  }

  /// Checks if the [examination] contains audio records that can be shared.
  @protected
  @visibleForTesting
  bool canShare(Examination examination) => examination.examinationPoints
      .any((examinationPoint) => examinationPoint.records.isNotEmpty);

  /// Checks if the [examination] is received from another person.
  @protected
  @visibleForTesting
  bool isReceived(Examination examination) => examination.from != null;
}
