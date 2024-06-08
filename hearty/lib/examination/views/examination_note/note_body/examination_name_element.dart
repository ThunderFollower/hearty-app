part of 'notes_body.dart';

class _ExaminationNameElement extends StatelessWidget {
  const _ExaminationNameElement({
    required this.controller,
    required this.textController,
    this.focusNode,
  });

  final ExaminationNotesController controller;
  final FocusNode? focusNode;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) => DiseasePageElement(
        title: LocaleKeys.NotesBody_Examination_Name.tr(),
        maxLength: 100,
        updateElement: controller.updateName,
        focusNode: focusNode,
        controller: textController,
      );
}
