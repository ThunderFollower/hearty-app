import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user_by_email_response_dto.freezed.dart';
part 'register_user_by_email_response_dto.g.dart';

/// Represents the response containing access and refresh tokens as defined in
/// Section 4 of RFC 6750.
@freezed
class RegisterUserByEmailResponseDto with _$RegisterUserByEmailResponseDto {
  /// Create a new [RegisterUserByEmailDto] object.
  const factory RegisterUserByEmailResponseDto({
    /// The user's id.
    required String id,

    /// The access token represents the authorization grant's scope, duration,
    /// and other attributes.
    @JsonKey(name: 'access_token') required String accessToken,

    /// The type of the access token.
    @JsonKey(name: 'token_type') required String tokenType,

    /// The time to live in seconds of the access token.
    @JsonKey(name: 'expires_in') required int expiresIn,

    /// The refresh token can be used to obtain a new access token without user
    /// interaction.
    @JsonKey(name: 'refresh_token') required String refreshToken,
  }) = _RegisterUserByEmailResponseDto;

  /// Deserialize [RegisterUserByEmailResponseDto] from the given [json] object.
  factory RegisterUserByEmailResponseDto.fromJson(Map<String, dynamic> json) =
      _RegisterUserByEmailResponseDto.fromJson;
}
