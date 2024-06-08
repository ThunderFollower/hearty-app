import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/storage/serializable.dart';

part 'two_factor_authentication_code_dto.freezed.dart';
part 'two_factor_authentication_code_dto.g.dart';

@freezed
class TwoFactorAuthenticationCodeDto
    with _$TwoFactorAuthenticationCodeDto
    implements Serializable<TwoFactorAuthenticationCodeDto> {
  const factory TwoFactorAuthenticationCodeDto({
    /// 2-step verification code. A value is a number string of 6 decimal digits.
    /// example: "confirmation_code": "123456"
    @JsonKey(name: 'confirmation_code') required String confirmationCode,

    /// UUID; Unique device/installation identifier.
    /// example: `"3fa85f64-5717-4562-b3fc-2c963f66afa6"`
    @JsonKey(name: 'device_identifier') required String deviceIdentifier,
  }) = _TwoFactorAuthenticationCodeDto;

  /// Deserialize [TwoFactorAuthenticationCodeDto] from the given [json] object.
  factory TwoFactorAuthenticationCodeDto.fromJson(Map<String, dynamic> json) =
      _TwoFactorAuthenticationCodeDto.fromJson;
}
