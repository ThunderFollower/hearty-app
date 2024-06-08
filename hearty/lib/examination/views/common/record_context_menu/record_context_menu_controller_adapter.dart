import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import '../../../../../../../core/views/index.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../../../utils/mixins/index.dart';
import '../../../examination.dart';
import 'record_context_menu_controller.dart';

class RecordContextMenuControllerAdapter
    with SubscriptionManager
    implements RecordContextMenuController {
  RecordContextMenuControllerAdapter(
    this.recordId, {
    required this.showStethoscope,
    required this.router,
    required this.recordService,
  });

  final String recordId;

  @protected
  final StackRouter router;

  @protected
  final ShowStethoscopeUseCase showStethoscope;
  @protected
  final RecordService recordService;

  void dispose() {
    cancelSubscriptions();
  }

  @override
  Future<bool?> onDelete() {
    final context = router.navigatorKey.currentState!.context;
    final dialog = _buildDeletingDialog();
    return showModalDialog(context: context, child: dialog);
  }

  @override
  Future<bool?> onRecordAgain() {
    final context = router.navigatorKey.currentState!.context;
    final dialog = _buildReplacingDialog();
    return showModalDialog(context: context, child: dialog);
  }

  Widget _buildReplacingDialog() => ConfirmationDialog(
        header: LocaleKeys.Replace_Recording.tr(),
        buttonLabel: LocaleKeys.Replace.tr(),
        description: LocaleKeys.This_recording_will_be_replaced.tr(),
        action: _onConfirmed,
      );

  Widget _buildDeletingDialog() => ConfirmationDialog(
        header: LocaleKeys.Delete_Recording.tr(),
        buttonLabel: LocaleKeys.Delete.tr(),
        description: LocaleKeys.This_recording_will_be_permanently_deleted.tr(),
        action: _onConfirmed,
      );

  Future<void> _onConfirmed() async {
    // Pop a confirmation alert
    if (router.canPop()) await router.pop(true);
    // Pop the context menu
    if (router.canPop()) await router.pop(true);
  }
}
