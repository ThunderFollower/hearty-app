import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import '../../examination.dart';
import '../../views/examination/examination_controller.dart';
import '../../views/examination_root/examination_list_controller.dart';
import '../main_page/content/received/list/received_list_controller.dart';
import 'attention_dialog/attention_dialog.dart';
import 'note_body/age_picker.dart';
import 'notes_processing_state.dart';
import 'notes_state.dart';

class ExaminationNotesController extends StateNotifier<NotesState> {
  ExaminationNotesController(
    AsyncValue<Examination> examination,
    StackRouter router,
    ExaminationController examinationController,
    ReceivedListController receivedListController,
    ExaminationListController examinationListController,
  )   : _examination = examination,
        _router = router,
        _examinationController = examinationController,
        _receivedListController = receivedListController,
        _examinationListController = examinationListController,
        super(NotesState()) {
    _examination.whenData((value) {
      state = NotesState.fromExamination(value);
    });

    state.titleFocusNode.addListener(setDefaultTitle);
  }

  late final AsyncValue<Examination> _examination;
  final StackRouter _router;
  // TODO: Avoid coupling with another controller.
  final ExaminationController _examinationController;

  final ReceivedListController _receivedListController;

  final ExaminationListController _examinationListController;

  List<Disease>? get heartDiseases => state.diseases.heartDiseases;

  List<Disease>? get lungDiseases => state.diseases.lungDiseases;

  bool get isNotesUnchanged {
    final result = _examination.mapOrNull(
      data: (data) {
        final value = data.value;
        return state.title.trim() == value.title &&
            (state.notes ?? '').trim() == (value.notes ?? '') &&
            state.diseases.heartDiseases == value.diseases.heartDiseases &&
            state.diseases.lungDiseases == value.diseases.lungDiseases &&
            state.age == value.age &&
            state.weight == value.weight;
      },
    );

    return result ?? false;
  }

  @override
  void dispose() {
    state.titleFocusNode.removeListener(setDefaultTitle);
    state.titleFocusNode.dispose();
    state.titleController.dispose();
    super.dispose();
  }

  void setDefaultTitle() {
    if (state.titleFocusNode.hasFocus) {
      return;
    }
    if (state.title.isEmpty) {
      state.titleController.text = LocaleKeys.Examination.tr();
      state = state.copyWith(newTitle: LocaleKeys.Examination.tr());
    }
  }

  Future<void> save() async {
    try {
      await _save();
      await _router.pop();
    } catch (e) {
      // TODO add workaround for error
      state = state.copyWith(newSavingState: NotesProcessingState.error);
    }
  }

  Future<void> showAlert() {
    final context = _router.navigatorKey.currentState!.context;
    return showModalDialog(
      context: context,
      child: const AttentionDialog(),
    );
  }

  Future<void> _save() async {
    if (!isNotesUnchanged || _examination.value!.isNew) {
      state = state.copyWith(newSavingState: NotesProcessingState.saving);
      final Examination? newExamination = _createNewExamination();
      if (newExamination != null) {
        await _saveExamination(newExamination);
      }
    }
  }

  Examination? _createNewExamination() {
    final result = _examination.mapOrNull(
      data: (data) {
        final value = data.value;

        return value.copyWith(
          title: state.title.isEmpty
              ? LocaleKeys.Examination.tr()
              : state.title.trim(),
          notes: state.notes?.isEmpty ?? true ? null : state.notes?.trim(),
          diseases: state.diseases,
          modifiedAt: DateTime.now().toUtc(),
          age: _isNotSelected() ? null : state.age,
          weight: state.weight != 0 ? state.weight : null,
        );
      },
    );
    assert(result != null, 'The examination was not loaded.');
    return result;
  }

  bool _isNotSelected() => (state.age ?? 0) < _minAge;

  Future<void> _saveExamination(Examination newExamination) async {
    late final Examination exam;

    if (_isReceivedExamination(state)) {
      exam = await _receivedListController.save(newExamination);
    } else {
      exam = await _examinationListController.save(newExamination);
    }

    if (exam.id != null) {
      _examinationController.init(id: exam.id!);
    }
  }

  bool _isReceivedExamination(NotesState state) => state.from != null;

  void updateName(String name) {
    state = state.copyWith(newTitle: name);
  }

  void updateNotes(String notes) {
    state = state.copyWith(newNotes: notes);
  }

  void openAgePicker() {
    final context = _router.navigatorKey.currentState!.context;
    final picker = AgePicker(onSelected: _updateAge, selectedValue: state.age);
    showCupertinoModalPopup(context: context, builder: (_) => picker);
  }

  void _updateAge(int age) => state = state.copyWith(age: age);

  void updateWeight(int weight) => state = state.copyWith(weight: weight);

  void updateDiseases(OrganType type, List<Disease> result) {
    if (type == OrganType.heart) {
      _updateHeartDiseases(result);
    } else if (type == OrganType.lungs) {
      _updateLungDiseases(result);
    }
  }

  void removeDisease(OrganType type, Disease disease) {
    if (type == OrganType.heart) {
      _removeHeartDisease(disease);
    } else if (type == OrganType.lungs) {
      _removeLungDisease(disease);
    }
  }

  Future<bool> isDismissingConfirmed() async {
    if (_isSavingInProgress()) return false;
    if (isNotesUnchanged) return true;
    return await _showConfirmationDialog() ?? false;
  }

  Future<void> dismiss() => _router.pop();

  Future<void> navigateBack() async {
    if (await isDismissingConfirmed()) {
      await dismiss();
    }
  }

  bool _isSavingInProgress() =>
      state.processingState == NotesProcessingState.saving;

  Future<bool?> _showConfirmationDialog<T>() {
    final context = _router.navigatorKey.currentState!.context;

    final dialog = _buildConfirmationDialog();

    return showModalDialog<bool?>(context: context, child: dialog);
  }

  Widget _buildConfirmationDialog() => ConfirmationDialog(
        header: LocaleKeys.Discard_Changes.tr(),
        buttonLabel: LocaleKeys.Discard.tr(),
        description: LocaleKeys.Unsaved_changes_will_be_deleted.tr(),
        action: _popUntilExaminationPage,
      );

  Future<bool> _popUntilExaminationPage() => _router.pop(true);

  void _updateHeartDiseases(List<Disease> updatedHeartDiseases) {
    state = state.copyWith(
      newDiseases: state.diseases.copyWith(
        heartDiseases: updatedHeartDiseases,
      ),
    );
  }

  void _updateLungDiseases(List<Disease> updatedLungDiseases) {
    state = state.copyWith(
      newDiseases: state.diseases.copyWith(
        lungDiseases: updatedLungDiseases,
      ),
    );
  }

  void _removeHeartDisease(Disease heartDisease) {
    final diseases = List<Disease>.from(state.diseases.heartDiseases);
    diseases.removeWhere((element) => element == heartDisease);
    state = state.copyWith(
      newDiseases: state.diseases.copyWith(
        heartDiseases: diseases,
      ),
    );
  }

  void _removeLungDisease(Disease lungDisease) {
    final diseases = List<Disease>.from(state.diseases.lungDiseases);
    diseases.removeWhere((element) => element == lungDisease);
    state = state.copyWith(
      newDiseases: state.diseases.copyWith(
        lungDiseases: diseases,
      ),
    );
  }

  /// The minimum age available to select.
  static const _minAge = int.fromEnvironment(
    'MIN_AGE',
    defaultValue: 18,
  );
}
