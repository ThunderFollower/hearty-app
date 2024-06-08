import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';
import '../constants.dart';

part 'authorize_dto.freezed.dart';
part 'authorize_dto.g.dart';

/// Defines a Data Transfer Object of the Authorization Request. See
/// [Authorize a user by signing a document](http://localhost:3000/swagger/#/authentication/AuthenticationController_signDocument)
@freezed
class AuthorizeDto with _$AuthorizeDto implements Serializable<AuthorizeDto> {
  const factory AuthorizeDto({
    /// UUID; Unique document identifier.
    /// example: `'3fa85f64-5717-4562-b3fc-2c963f66afa6'`
    @JsonKey(name: documentIdentifierName) required String documentId,
  }) = _AuthorizeDto;

  /// Deserialize [AuthorizeDto] from the given [json] object.
  factory AuthorizeDto.fromJson(Json json) = _AuthorizeDto.fromJson;
}
