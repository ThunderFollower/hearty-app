part of 'notes_body.dart';

class _NotesElement extends StatelessWidget {
  const _NotesElement({required this.controller, this.initialValue});

  final ExaminationNotesController controller;
  final String? initialValue;

  @override
  Widget build(BuildContext context) => DiseasePageElement(
        title: LocaleKeys.NotesBody_Notes_title.tr(),
        titleTap: controller.showAlert,
        hintText: LocaleKeys.NotesBody_Notes_hint.tr(),
        initialValue: initialValue,
        updateElement: controller.updateNotes,
        minLines: 7,
        maxLines: 7,
        maxLength: 5000,
      );
}
