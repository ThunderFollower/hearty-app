import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/user.dart';

part 'user_response_dto.freezed.dart';
part 'user_response_dto.g.dart';

/// Defines Data Transfer Object for responses that are a [User] entity.
///
/// See
/// [Sign-up API](https://test.sparrowbiologic.com/swagger/#/authentication/finishRegistration),
/// [Password Reset API](https://test.sparrowbiologic.com/swagger/#/authentication/AuthenticationController_recoverPassword),
/// [Get User API](https://test.sparrowbiologic.com/swagger/#/authentication/me).
@freezed
class UserResponseDto with _$UserResponseDto implements User {
  /// Create a new [UserResponseDto] object.
  const factory UserResponseDto({
    /// UUID; Unique identifier of the user.
    /// Example: `"3fa85f64-5717-4562-b3fc-2c963f66afa6"`.
    required String id,

    /// The user email address for login
    /// Example: `"user@example.com"`.
    required String email,
  }) = _UserResponseDto;

  /// Deserialize [UserResponseDto] from the given [json] object.
  factory UserResponseDto.fromJson(Map<String, dynamic> json) =
      _UserResponseDto.fromJson;
}
