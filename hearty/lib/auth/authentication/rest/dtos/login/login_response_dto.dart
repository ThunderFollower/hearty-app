import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
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

    /// The value is true when authentication of second factor is needed.
    @JsonKey(name: 'needs_two_factor_verification')
    required bool needsTwoFactorVerification,
  }) = _LoginResponseDto;

  /// Deserialize [LoginResponseDto] from the given [json] object.
  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =
      _LoginResponseDto.fromJson;
}
