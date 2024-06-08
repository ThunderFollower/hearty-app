import 'package:freezed_annotation/freezed_annotation.dart';

part 'bearer_token_response_dto.freezed.dart';
part 'bearer_token_response_dto.g.dart';

@freezed
class BearerTokenResponseDto with _$BearerTokenResponseDto {
  const factory BearerTokenResponseDto({
    /// User's ID.
    /// @example: 9052081a-d30c-47d1-a546-4b8585c677c1
    required String id,

    /// The access token represents the grant's scope.
    /// example: mF_9.B5f-4.1JqM
    @JsonKey(name: 'access_token') required String accessToken,

    /// Bearer
    @JsonKey(name: 'token_type') required String tokenType,

    /// Time to live in seconds.
    /// example: 3600
    @JsonKey(name: 'expires_in') required int expiresIn,

    /// Allows an application to obtain a new access token without prompting
    /// the user.
    /// example: tGzV3JOkF0XG5Q2xTlKWIA
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _BearerTokenResponseDto;

  /// Deserialize [BearerTokenResponseDto] from the given [json] object.
  factory BearerTokenResponseDto.fromJson(Map<String, dynamic> json) =
      _BearerTokenResponseDto.fromJson;
}
