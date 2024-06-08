import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';
import '../../../../body_side.dart';

part 'create_record_dto.freezed.dart';
part 'create_record_dto.g.dart';

@freezed
class CreateRecordDto
    with _$CreateRecordDto
    implements Serializable<CreateRecordDto> {
  const factory CreateRecordDto({
    @JsonKey(name: 'body_position') required BodyPosition bodyPosition,
    @JsonKey(name: 'examination_point_id') required String examinationPointId,
    @JsonKey(name: 'asset_id') required String assetId,
  }) = _CreateRecordDto;

  factory CreateRecordDto.fromJson(Map<String, dynamic> json) =>
      _$CreateRecordDtoFromJson(json);
}
