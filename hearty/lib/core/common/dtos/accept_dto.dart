import 'package:freezed_annotation/freezed_annotation.dart';

import '../../storage/index.dart';
import 'constants.dart';

part 'accept_dto.freezed.dart';
part 'accept_dto.g.dart';

/// Defines Data Transfer Object that keeps the 'Accept' request HTTP header.
///
/// See also [Getting Document](https://test.sparrowbiologic.com/swagger/#/document/DocumentController_findOne).
@freezed
class AcceptDto with _$AcceptDto implements Serializable<AcceptDto> {
  factory AcceptDto({
    /// The Accept request HTTP header, expressed as MIME types,
    /// indicates which content types the client understands.
    /// The server uses content negotiation to select one of the proposals
    /// and informs the client of choice with the Content-Type response header.
    @JsonKey(name: acceptHeaderName) required String accept,
  }) = _AcceptDto;

  /// Deserialize a [AcceptDto] object from the given [json] object.
  factory AcceptDto.fromJson(Json json) = _AcceptDto.fromJson;
}
