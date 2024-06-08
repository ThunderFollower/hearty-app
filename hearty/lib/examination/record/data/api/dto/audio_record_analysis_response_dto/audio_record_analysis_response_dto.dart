import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/storage/serializable.dart';
import '../../../../record_analysis_status.dart';

part 'audio_record_analysis_response_dto.freezed.dart';
part 'audio_record_analysis_response_dto.g.dart';

@freezed
class AudioRecordAnalysisResponseDto
    with _$AudioRecordAnalysisResponseDto
    implements Serializable<AudioRecordAnalysisResponseDto> {
  factory AudioRecordAnalysisResponseDto({
    required String id,
    required RecordAnalysisStatus analysis,
  }) = _AudioRecordAnalysisResponseDto;

  /// Deserialize a [AudioRecordAnalysisResponseDto] object from the given [json] object.
  factory AudioRecordAnalysisResponseDto.fromJson(Json json) =
      _AudioRecordAnalysisResponseDto.fromJson;
}
