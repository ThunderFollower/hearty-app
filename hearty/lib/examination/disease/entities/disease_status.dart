import 'package:freezed_annotation/freezed_annotation.dart';

import 'disease.dart';
part 'disease_status.freezed.dart';

@freezed
class DiseaseStatus with _$DiseaseStatus {
  const factory DiseaseStatus({
    required Disease disease,
    @Default(false) bool isSelected,
  }) = _DiseaseStatus;
}
