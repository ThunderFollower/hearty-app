import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/storage/serializable.dart';
import '../../disease/entities/disease.dart';

part 'examination_diseases.freezed.dart';

@freezed
class ExaminationDiseases with _$ExaminationDiseases {
  static const _heartCode = 'heart';
  static const _lungCode = 'lung';

  const factory ExaminationDiseases({
    @Default(<Disease>[]) List<Disease> heartDiseases,
    @Default(<Disease>[]) List<Disease> lungDiseases,
  }) = _ExaminationDiseases;

  const ExaminationDiseases._();

  factory ExaminationDiseases.fromJson(Map<String, dynamic> json) {
    return ExaminationDiseases(
      heartDiseases: _diseasesfromJson(json, _heartCode),
      lungDiseases: _diseasesfromJson(json, _lungCode),
    );
  }

  Json toJson() {
    final Map<String, dynamic> result = <String, dynamic>{};
    result[_heartCode] = _diseaseCodes(heartDiseases);
    result[_lungCode] = _diseaseCodes(lungDiseases);
    return result;
  }

  List<dynamic> _diseaseCodes(List<Disease> diseases) =>
      diseases.map((e) => e.key).toList();

  static List<Disease> _diseasesfromJson(Json json, String key) {
    return (json[key] as List<dynamic>)
        .map((e) => e as String)
        .map((e) => Disease(e))
        .toList();
  }

  bool get hasHeartDiseases => heartDiseases.isNotEmpty;

  bool get hasLungDiseases => lungDiseases.isNotEmpty;
}
