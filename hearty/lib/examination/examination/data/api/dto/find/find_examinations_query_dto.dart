import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';

part 'find_examinations_query_dto.freezed.dart';
part 'find_examinations_query_dto.g.dart';

@freezed
class FindExaminationsQueryDto
    with _$FindExaminationsQueryDto
    implements Serializable<FindExaminationsQueryDto> {
  const factory FindExaminationsQueryDto({
    required int offset,
    required int limit,
    bool? received,
    bool? mine,
  }) = _FindExaminationsQueryDto;

  /// Create [FindExaminationsQueryDto] from the given [json].
  factory FindExaminationsQueryDto.fromJson(Map<String, dynamic> json) =>
      _$FindExaminationsQueryDtoFromJson(json);
}
