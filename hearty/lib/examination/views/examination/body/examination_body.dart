import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../examination/entities/examination.dart';
import '../../main_page/content/common/actions/port/action_controller.dart';
import '../../main_page/content/common/actions/share_button_controller_provider.dart';
import 'config/examination_body_controller_provider.dart';
import 'examination_body_controller.dart';
import 'modal_menu/modal_menu.dart';
import 'note_button/notes_button.dart';
import 'record_bottom/record_bottom.dart';

class ExaminationBody extends ConsumerWidget {
  const ExaminationBody({
    super.key,
    required this.examination,
    this.mutable = true,
  });

  final Examination examination;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examId = examination.id;
    final controllerProvider = examinationBodyControllerProvider(examId);
    final controller = ref.watch(controllerProvider);
    final actionButtonController = _getActionController(examination, ref);
    final theme = Theme.of(context);
    return Stack(
      children: [
        Column(
          children: <Widget>[
            _buildAppBar(
              ref,
              context,
              examination,
              actionButtonController,
              controller,
              theme,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                const LocalImage(assetPath: 'assets/images/logo.png'),
                Padding(
                  padding: _infoButtonPadding,
                  child: NotesButton(
                    onButtonPressed: controller.openEditNotesPage,
                  ),
                ),
              ],
            ),
          ],
        ),
        RecordBottom(examination: examination, mutable: mutable),
      ],
    );
  }

  ActionController? _getActionController(
    Examination examination,
    WidgetRef ref,
  ) {
    if (examination.id == null) return null;

    final controllerProvider = shareButtonControllerProvider(
      examination.id!,
    );
    return ref.watch(controllerProvider);
  }

  Widget _buildAppBar(
    WidgetRef ref,
    BuildContext context,
    Examination examination,
    ActionController? actionButtonController,
    ExaminationBodyController controller,
    ThemeData theme,
  ) {
    final menuIconColor = theme.colorScheme.onPrimary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            onPressed: controller.closeExaminationPage,
            icon: AppLocator(
              id: 'close_button',
              child: Icon(
                key: _closeButtonKey,
                AppIcons.close,
                color: AppColors.grey.shade900,
              ),
            ),
          ),
        ),
        const SizedBox(height: veryHighIndent, width: veryHighIndent),
        Expanded(
          child: Text(
            examination.title,
            semanticsLabel: '${examination.title}_examination_name',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.grey[900],
              fontSize: 18,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (!examination.isNew) ...[
          IconButton(
            onPressed: actionButtonController?.onPressed,
            icon: AppLocator(
              id: 'share_button',
              child: SvgPicture.asset('assets/images/share.svg'),
            ),
          ),
          IconButton(
            onPressed: () async {
              showModalDialog(
                context: context,
                child: ModalMenu(
                  labels: [
                    LocaleKeys.Edit_Information.tr(),
                    LocaleKeys.Delete_Examination.tr(),
                  ],
                  actions: [
                    () => controller.openEditNotesPage(),
                    () => _deleteExamination(controller, context),
                  ],
                ),
              );
            },
            icon: AppLocator(
              id: 'menu_button',
              child: Icon(
                AppIcons.actions,
                color: menuIconColor,
              ),
            ),
          ),
        ] else
          const SizedBox(
            width: extremelyHightIndent + veryHighIndent,
            height: extremelyHightIndent,
          ),
      ],
    );
  }

  Future<void> _deleteExamination(
    ExaminationBodyController controller,
    BuildContext context,
  ) async {
    await showModalDialog<bool>(
      context: context,
      child: ConfirmationDialog(
        header: '${LocaleKeys.Delete_Examination.tr()}?',
        buttonLabel: LocaleKeys.Delete.tr(),
        description:
            LocaleKeys.The_examination_and_all_its_records_will_be_deleted.tr(),
        action: () => controller.deleteExamination(),
      ),
    );
  }
}

const _infoButtonPadding = EdgeInsets.only(
  left: belowLowIndent,
  right: lowIndent,
  top: 14,
);

// Keys
const _closeButtonKey = Key('close_button_key');
