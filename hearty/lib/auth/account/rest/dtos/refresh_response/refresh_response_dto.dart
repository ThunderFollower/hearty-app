import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_response_dto.freezed.dart';
part 'refresh_response_dto.g.dart';

/// Defines Data Transfer Object of Access Token Response.
@freezed
class RefreshResponseDto with _$RefreshResponseDto {
  const factory RefreshResponseDto({
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
  }) = _RefreshResponseDto;

  /// Deserialize [RefreshResponseDto] from the given [json] object.
  factory RefreshResponseDto.fromJson(Map<String, dynamic> json) =
      _RefreshResponseDto.fromJson;
}
