import 'package:freezed_annotation/freezed_annotation.dart';

import 'examination_short.dart';

part 'examination_list.freezed.dart';
part 'examination_list.g.dart';

@freezed
class ExaminationList with _$ExaminationList {
  const factory ExaminationList({
    required int pages,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'items') required Set<ExaminationShort> examinations,
  }) = _ExaminationList;

  const ExaminationList._();

  factory ExaminationList.fromJson(Map<String, dynamic> json) =>
      _$ExaminationListFromJson(json);
}
