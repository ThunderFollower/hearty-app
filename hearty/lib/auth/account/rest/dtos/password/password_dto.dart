import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';

part 'password_dto.freezed.dart';
part 'password_dto.g.dart';

/// Defines Data Transfer Object that keeps a user's password.
///
/// See
/// [Sign-up API](https://test.sparrowbiologic.com/swagger/#/authentication/finishRegistration),
/// [Password Reset API](https://test.sparrowbiologic.com/swagger/#/authentication/AuthenticationController_recoverPassword).
@freezed
class PasswordDto with _$PasswordDto implements Serializable<PasswordDto> {
  /// Create a new [PasswordDto] object.
  const factory PasswordDto({
    /// A user's password must meet
    /// [password requirements](https://sparrowacoustics.atlassian.net/l/c/2F2tsyat#SecR-14).
    /// Example: `"PassWord%1"`
    required String password,
  }) = _PasswordDto;

  /// Deserialize [PasswordDto] from the given [json] object.
  factory PasswordDto.fromJson(Map<String, dynamic> json) =
      _PasswordDto.fromJson;
}
