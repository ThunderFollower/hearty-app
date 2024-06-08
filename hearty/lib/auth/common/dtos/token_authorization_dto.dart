import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';

part 'token_authorization_dto.freezed.dart';
part 'token_authorization_dto.g.dart';

/// Defines the Data Transfer Object of authorization by a unique token.
@freezed
class TokenAuthorizationDto
    with _$TokenAuthorizationDto
    implements Serializable<TokenAuthorizationDto> {
  /// Create a new [TokenAuthorizationDto] object.
  const factory TokenAuthorizationDto({
    /// A unique token for authorization.
    required String token,
  }) = _TokenAuthorizationDto;

  /// Deserialize [TokenAuthorizationDto] from the given [json] object.
  factory TokenAuthorizationDto.fromJson(Map<String, dynamic> json) =
      _TokenAuthorizationDto.fromJson;
}
