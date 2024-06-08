import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../examination.dart';
import '../config/examination_notes_state_provider.dart';
import '../examination_notes_controller.dart';
import '../notes_processing_state.dart';
import '../notes_state.dart';
import 'disease_element/disease_page_element.dart';
import 'disease_selector/disease_selector.dart';
import 'keyboard_controller.dart';
import 'note_text_info/note_text_info.dart';

part 'notes_element.dart';
part 'save_button.dart';
part 'weight_element.dart';
part 'age_element.dart';
part 'examination_name_element.dart';

/// To validate text fields.
final notesBodyFormKey = GlobalKey<FormState>();

class NotesBody extends ConsumerStatefulWidget {
  const NotesBody({super.key});

  @override
  ConsumerState<NotesBody> createState() => _NotesBodyState();
}

class _NotesBodyState extends ConsumerState<NotesBody>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    ref.read(keyboardControllerProvider.notifier).specifyKeyboardVisibility();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(examinationNotesStateProvider);
    final controller = ref.watch(examinationNotesStateProvider.notifier);
    final keyboardState = ref.watch(keyboardControllerProvider);

    final loader = Loader(text: '${LocaleKeys.Saving.tr()}...');
    const middleVerticalIndent = SizedBox(height: middleIndent);
    const lowVerticalIndent = SizedBox(height: lowIndent);
    final nameElement = _ExaminationNameElement(
      controller: controller,
      focusNode: state.titleFocusNode,
      textController: state.titleController,
    );
    final ageElement = _AgeElement(
      controller: controller,
      value: state.age,
      mutable: !_isReceived(state.from),
    );
    final weightElement = _WeightElement(
      controller: controller,
      initialValue: state.weight,
      mutable: !_isReceived(state.from),
    );
    final heartDiseases = DiseaseSelector(
      title: LocaleKeys.NotesBody_Heart_Diseases.tr(),
      diseases: state.diseases.heartDiseases,
      type: OrganType.heart,
    );

    final notes = _NotesElement(
      controller: controller,
      initialValue: state.notes,
    );
    final createdAt = _buildCreatedAt(state);
    final sentFrom = NoteTextInfo(
      title: LocaleKeys.From.tr(),
      mainText: state.from ?? '',
    );
    final modifiedAt = NoteTextInfo(
      title: LocaleKeys.NotesBody_Modified.tr(),
      mainText: _formatDate(state.modifiedAt ?? DateTime.now()),
    );
    final column = Form(
      key: notesBodyFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          nameElement,
          lowVerticalIndent,
          ageElement,
          lowVerticalIndent,
          weightElement,
          middleVerticalIndent,
          notes,
          lowVerticalIndent,
          heartDiseases,
          lowVerticalIndent,
          if (_isValidText(state.from)) ...[
            sentFrom,
            middleVerticalIndent,
          ],
          createdAt,
          middleVerticalIndent,
          if (_isValidText(state.modifiedAt?.toString())) ...[
            modifiedAt,
            middleVerticalIndent,
          ],
          if (_isKeyboardVisible(keyboardState))
            _SaveButton(onTap: controller.save),
        ],
      ),
    );
    final scrollView = SingleChildScrollView(padding: _padding, child: column);
    final appScaffold = _buildAppScaffold(
      scrollView,
      keyboardState,
      controller,
    );

    return state.processingState == NotesProcessingState.saving
        ? loader
        : appScaffold;
  }

  Widget _buildCreatedAt(NotesState notesState) {
    final title = _isValidText(notesState.from)
        ? LocaleKeys.NotesBody_Received
        : LocaleKeys.NotesBody_Created;

    return NoteTextInfo(
      title: title.tr(),
      mainText: _formatDate(notesState.createdAt),
    );
  }

  AppScaffold _buildAppScaffold(
    SingleChildScrollView scrollView,
    KeyboardState keyboardState,
    ExaminationNotesController controller,
  ) =>
      AppScaffold(
        body: scrollView,
        bottomNavigationBar: _isKeyboardVisible(keyboardState)
            ? null
            : _SaveButton(
                onTap: controller.save,
                shouldAddHorizontalPaddings: true,
              ),
      );

  bool _isKeyboardVisible(KeyboardState keyboardState) =>
      keyboardState.statusState == KeyboardStatusState.visible;

  bool _isValidText(String? text) => text != null && text.isNotEmpty;

  String _formatDate(DateTime date) {
    final localDate = date.toLocal();
    return DateFormat.yMMMd().add_jm().format(localDate);
  }

  bool _isReceived(String? data) => _isValidText(data);
}

const _padding = EdgeInsets.symmetric(horizontal: middleIndent);
