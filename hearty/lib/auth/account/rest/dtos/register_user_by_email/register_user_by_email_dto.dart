import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';

part 'register_user_by_email_dto.freezed.dart';
part 'register_user_by_email_dto.g.dart';

/// A data transfer object (DTO) used to register a new user account by email.
///
/// This DTO defines the email and password fields required to create a new user
/// account using email as the login method.
@freezed
class RegisterUserByEmailDto
    with _$RegisterUserByEmailDto
    implements Serializable<RegisterUserByEmailDto> {
  /// Create a new [RegisterUserByEmailDto] object.
  const factory RegisterUserByEmailDto({
    /// The user email address for login in lowercase.
    /// Example: `"user@example.com"`.
    required String email,

    /// A user's password must meet password requirements.
    /// Example: `"PassWord%1"`
    required String password,
  }) = _RegisterUserByEmailDto;

  /// Deserialize [RegisterUserByEmailDto] from the given [json] object.
  factory RegisterUserByEmailDto.fromJson(Map<String, dynamic> json) =
      _RegisterUserByEmailDto.fromJson;
}
