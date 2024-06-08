import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:share_plus/share_plus.dart' as share_plus;
import 'package:share_plus/share_plus.dart';

import '../../../../../utils/mixins/subscription_manager.dart';
import '../../../../../utils/utils.dart';
import '../../../../examination.dart';
import '../sharing_controller.dart';
import '../sharing_state.dart';

class SharingControllerAdapter extends SharingController
    with SubscriptionManager {
  SharingControllerAdapter(
    this._router,
    this._showAcknowledgmentsUseCase,
    this.examinationId,
    this.examinationService,
    this.recordService,
    this.assetService,
  ) : super(const SharingState());

  @protected
  final ExaminationService examinationService;
  @protected
  final RecordService recordService;
  @protected
  final AssetService assetService;
  final StackRouter _router;
  final ShowAcknowledgmentsDialogUseCase _showAcknowledgmentsUseCase;
  final String examinationId;
  final Logger _logger = Logger();

  @override
  void toggle() {
    state = state.copyWith(isSendingConfirmed: !state.isSendingConfirmed);
  }

  @override
  Future<void> share() async {
    if (state.isBusy) return;
    try {
      state = state.copyWith(isBusy: true);

      examinationService
          .findOne(examinationId)
          .listen(_handleExamination)
          .addToList(this);
    } catch (error) {
      _logger.e('Share examination', error);
    } finally {
      if (mounted) state = state.copyWith(isBusy: false);
    }
  }

  Future<void> _handleExamination(Examination exam) async {
    final record = exam.examinationPoints.first.records.first;
    final id = record.id;

    if (id == null) return;

    recordService
        .findOne(id)
        .map((record) => record.asset)
        .distinct()
        .switchMap((asset) => loadAudioFilePath(asset))
        .where((event) => event != null)
        .listen(_handleAssetPath)
        .addToList(this);
  }

  Future<void> _handleAssetPath(String? event) async {
    await _router.pop();

    final directory = await getApplicationDocumentsDirectory();
    final documents = await directory.list().toList();

    final path = documents.firstWhere((e) => e.path.endsWith('.wav')).path;
    await share_plus.Share.shareXFiles([XFile(path)]);
  }

  @protected
  @visibleForTesting
  Stream<String?> loadAudioFilePath(Asset? asset) async* {
    if (asset != null) {
      yield await assetService.getCachedAssetUri(asset: asset);
    }
  }

  @override
  void showDocumentDialog() => _showAcknowledgmentsUseCase.execute();

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }
}
