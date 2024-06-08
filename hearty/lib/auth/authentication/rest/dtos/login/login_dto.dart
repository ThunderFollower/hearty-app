import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';

part 'login_dto.freezed.dart';
part 'login_dto.g.dart';

/// Defines Data Transfer Object of Login Request. See
/// [stethophone-backend API](https://test.sparrowbiologic.com/swagger/#/authentication/login)
@freezed
class LoginDto with _$LoginDto implements Serializable<LoginDto> {
  const factory LoginDto({
    /// UUID; Unique device/installation identifier.
    /// example: `'3fa85f64-5717-4562-b3fc-2c963f66afa6'`
    @JsonKey(name: 'device_identifier') required String deviceIdentifier,

    /// The user name for login.
    /// example: `'user@example.com'`
    required String email,

    /// The password for login
    /// example: `'MyPassword#1'`
    required String password,
  }) = _LoginDto;

  /// Deserialize [LoginDto] from the given [json] object.
  factory LoginDto.fromJson(Map<String, dynamic> json) = _LoginDto.fromJson;
}
