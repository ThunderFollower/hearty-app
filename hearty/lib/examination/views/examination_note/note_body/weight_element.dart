part of 'notes_body.dart';

class _WeightElement extends StatelessWidget {
  const _WeightElement({
    required this.controller,
    this.initialValue,
    this.mutable = true,
  });

  final ExaminationNotesController controller;
  final int? initialValue;
  final bool mutable;

  @override
  Widget build(BuildContext context) => DiseasePageElement(
        key: _weightFieldKey,
        title: _title,
        initialValue: _initialValue,
        updateElement: _updateWeight,
        hintText: LocaleKeys.NotesBody_Weight_title.tr(),
        textInputType: _textInputType,
        inputFormatters: <TextInputFormatter>[_inputFormatter],
        validator: validate,
        enabled: mutable,
      );

  String? get _initialValue {
    if (initialValue != null) {
      return '${initialValue! / _gramsInKilo}'.replaceAll('.', ',');
    }
    return null;
  }

  String get _title {
    final title = LocaleKeys.NotesBody_Weight_title.tr();
    final weightUnit = ' (${LocaleKeys.weightUnit.tr()})';
    return title + weightUnit;
  }

  void _updateWeight(String value) {
    if (notesBodyFormKey.currentState?.validate() == false) return;

    final parsedValue = _parseWeight(value);
    final weightInGrams = parsedValue != null ? _calculate(parsedValue) : 0;
    controller.updateWeight(weightInGrams);
  }

  int _calculate(double parsedValue) => (parsedValue * _gramsInKilo).toInt();

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty || _isValidWeight(value)) {
      return null;
    }
    return LocaleKeys.NotesBody_Weight_errorText.tr();
  }

  bool _isValidWeight(String value) {
    final parsedValue = _parseWeight(value);
    return parsedValue != null &&
        parsedValue * _gramsInKilo > 0.0 &&
        parsedValue * _gramsInKilo <= _maxWeight;
  }

  double? _parseWeight(String value) => double.tryParse(_replaceComma(value));

  String _replaceComma(String value) => value.replaceAll(',', '.');

  /// The maximum age displayed to select.
  static const _maxWeight = int.fromEnvironment(
    'MAX_WEIGHT',
    defaultValue: 365000,
  );
}

const _gramsInKilo = 1000;
const _textInputType = TextInputType.numberWithOptions(decimal: true);
const _weightFieldKey = Key('weight_field');
final _inputFormatter = FilteringTextInputFormatter.allow(
  RegExp(r'^(\d+)?\,?\d{0,2}'),
);
