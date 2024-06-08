import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/core.dart';

part 'create_share_dto.freezed.dart';
part 'create_share_dto.g.dart';

/// A Data Transfer Object for a request to create a shared object.
@freezed
class CreateShareDto
    with _$CreateShareDto
    implements Serializable<CreateShareDto> {
  /// Create a new [CreateShareDto] object.
  const factory CreateShareDto({
    /// The unique identifier of a prototype for the shared Examination object.
    @JsonKey(name: 'examination_identifier') required String examinationId,
  }) = _CreateShareDto;

  /// Deserialize [CreateShareDto] from the given [json] object.
  factory CreateShareDto.fromJson(Map<String, dynamic> json) =
      _CreateShareDto.fromJson;
}
