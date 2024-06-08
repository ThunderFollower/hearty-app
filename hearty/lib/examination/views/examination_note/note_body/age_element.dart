part of 'notes_body.dart';

class _AgeElement extends StatelessWidget {
  const _AgeElement({
    required this.controller,
    this.value,
    this.mutable = true,
  });

  final ExaminationNotesController controller;
  final int? value;
  final bool mutable;

  @override
  Widget build(BuildContext context) {
    final pageElement = DiseasePageElement(
      title: LocaleKeys.NotesBody_Age_title.tr(),
      hintText: _getHintText(),
      enabled: false,
    );

    return GestureDetector(
      onTap: mutable ? controller.openAgePicker : null,
      child: pageElement,
    );
  }

  String _getHintText() => value != null && value! >= _minAge
      ? LocaleKeys.age_format.plural(value!)
      : LocaleKeys.NotesBody_Age_Select_age.tr();

  /// The minimum age available to select.
  static const _minAge = int.fromEnvironment(
    'MIN_AGE',
    defaultValue: 18,
  );
}
