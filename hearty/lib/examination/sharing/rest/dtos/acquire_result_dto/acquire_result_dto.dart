import 'package:freezed_annotation/freezed_annotation.dart';

part 'acquire_result_dto.freezed.dart';
part 'acquire_result_dto.g.dart';

/// Defines a *Data Transfer Object* of the result of the acquisition of a
/// Shared Examination
@freezed
class AcquireResultDto with _$AcquireResultDto {
  /// Create a new [CreateShareDto] object.
  const factory AcquireResultDto({
    /// The unique identifier of a examination object.
    @JsonKey(name: 'examination_identifier') required String examinationId,
  }) = _AcquireResultDto;

  /// Deserialize [CreateShareDto] from the given [json] object.
  factory AcquireResultDto.fromJson(Map<String, dynamic> json) =
      _AcquireResultDto.fromJson;
}
