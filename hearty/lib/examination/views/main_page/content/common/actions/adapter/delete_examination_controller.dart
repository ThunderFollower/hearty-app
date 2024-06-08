import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../../../../core/views/dialog/confirmation_dialog.dart';
import '../../../../../../../core/views/show_modal_dialog.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../main_content_key.dart';
import '../../../received/list/received_list_controller.dart';
import '../port/action_controller.dart';

class DeleteExaminationController extends ActionController {
  const DeleteExaminationController({
    required this.examinationId,
    required this.router,
    required this.controller,
  });

  final String examinationId;
  final StackRouter router;

  // TODO: we should avoid coupling between controllers
  final ReceivedListController controller;

  @override
  void onPressed() {
    final context = mainContentKey.currentContext;
    if (context == null) return;

    final confirmationDialog = ConfirmationDialog(
      header: '${LocaleKeys.Delete_Examination.tr()}?',
      buttonLabel: LocaleKeys.Delete.tr(),
      description:
          LocaleKeys.The_examination_and_all_its_records_will_be_deleted.tr(),
      action: onAction,
    );
    showModalDialog<bool>(
      context: context,
      child: confirmationDialog,
    );
  }

  void onAction() {
    controller.deleteOne(examinationId);
    router.pop(true);
  }
}
