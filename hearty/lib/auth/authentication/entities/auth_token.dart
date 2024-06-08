import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_token.freezed.dart';
part 'auth_token.g.dart';

@freezed
class AuthToken with _$AuthToken {
  const factory AuthToken({
    required String id,
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    @Deprecated('use expiresInDate')
    @JsonKey(name: 'expires_in')
    int? expiresIn,
    DateTime? expiresInDate,
    @JsonKey(name: 'needs_two_factor_verification') @Default(true) bool needTFA,
  }) = _AuthToken;

  const AuthToken._();

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  // XXX: AuthToken entity should be a data structure with no functional elements
  bool get isExpired => expiresInDate?.isBefore(DateTime.now()) ?? true;
}
