import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';

part 'email_dto.freezed.dart';
part 'email_dto.g.dart';

/// Defines Data Transfer Object that keeps a user's email address.
///
/// See
/// [Sign-up API](https://test.sparrowbiologic.com/swagger/#/sign-up/SignUpController_signUpByEmail),
/// [Password Reset API](https://test.sparrowbiologic.com/swagger/#/authentication/AuthenticationController_resetPassword).
@freezed
class EmailDto with _$EmailDto implements Serializable<EmailDto> {
  /// Create a new [EmailDto] object.
  const factory EmailDto({
    /// The user email address for login in lowercase.
    /// Example: `"user@example.com"`.
    required String email,
  }) = _EmailDto;

  /// Deserialize [EmailDto] from the given [json] object.
  factory EmailDto.fromJson(Map<String, dynamic> json) = _EmailDto.fromJson;
}
