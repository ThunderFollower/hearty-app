import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/core.dart';
import '../../../../body_side.dart';
import '../../../../record_analysis_status.dart';

part 'update_record_dto.freezed.dart';
part 'update_record_dto.g.dart';

@freezed
class UpdateRecordDto
    with _$UpdateRecordDto
    implements Serializable<UpdateRecordDto> {
  const factory UpdateRecordDto({
    @JsonKey(name: 'body_position', includeIfNull: false)
    BodyPosition? bodyPosition,
    @JsonKey(name: 'examination_point_id', includeIfNull: false)
    String? examinationPointId,
    @JsonKey(name: 'asset_id') String? assetId,
    @JsonKey(name: 'analysis') RecordAnalysisStatus? analysisStatus,
  }) = _UpdateRecordDto;

  factory UpdateRecordDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateRecordDtoFromJson(json);
}
