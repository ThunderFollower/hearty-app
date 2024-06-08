import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../asset/index.dart';
import '../../../../body_side.dart';
import '../../../../record_analysis_status.dart';
import '../../../../spot.dart';

part 'audio_record_response_dto.freezed.dart';
part 'audio_record_response_dto.g.dart';

@freezed
class AudioRecordResponseDto with _$AudioRecordResponseDto {
  const factory AudioRecordResponseDto({
    required String id,
    @JsonKey(name: 'examination_point_id') required String examinationPointId,
    @JsonKey(name: 'body_position') required BodyPosition bodyPosition,
    required Asset asset,
    @JsonKey(name: 'asset_id') required String assetId,
    @JsonKey(name: 'analysis') required RecordAnalysisStatus analysisStatus,
    @JsonKey(name: 'examination_id') required String examinationId,
    required Spot spot,
  }) = _AudioRecordResponseDto;

  factory AudioRecordResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordResponseDtoFromJson(json);
}
