import '../../../core/core.dart';
import '../../common/index.dart';
import '../entities/auth_token.dart';
import '../ports/auth_token_repository.dart';
import 'constants.dart';
import 'dtos/authorize/authorize_dto.dart';
import 'dtos/bearer_token/bearer_token_response_dto.dart';
import 'dtos/device/device_dto.dart';
import 'dtos/login/login_dto.dart';
import 'dtos/login/login_response_dto.dart';
import 'dtos/two_factor_authentication_code/two_factor_authentication_code_dto.dart';
import 'dtos/user_agent/user_agent_dto.dart';

class AuthTokenRepositoryApiAdapter implements AuthTokenRepository {
  /// Construct and initialize a new repository with the given HTTP client.
  const AuthTokenRepositoryApiAdapter(
    this.publicDataSource,
    this.privateDataSource,
    this.cancelable,
  );

  /// A data source object to access public API.
  final HttpDataSource publicDataSource;

  /// A data source object to access private API.
  final HttpDataSource privateDataSource;

  /// A cancelable object to cancel HTTP requests.
  final Cancelable cancelable;

  @override
  Future<AuthToken> signIn({
    required String email,
    required String password,
    required String deviceIdentifier,
  }) async {
    final DateTime timestamp = DateTime.now();
    final loginDto = LoginDto(
      email: email,
      password: password,
      deviceIdentifier: deviceIdentifier,
    );
    final responseDto = await publicDataSource.post(
      pathToSignIn,
      body: loginDto,
      cancelable: cancelable,
      deserializer: LoginResponseDto.fromJson,
    );

    return _authTokenFromLoginResponseDto(responseDto, timestamp: timestamp);
  }

  @override
  Future<AuthToken> authorize({required String documentId}) async {
    final DateTime timestamp = DateTime.now();
    final authorizeDto = AuthorizeDto(documentId: documentId);
    final responseDto = await privateDataSource.post(
      pathToAuthorize,
      body: authorizeDto,
      cancelable: cancelable,
      deserializer: LoginResponseDto.fromJson,
    );
    return _authTokenFromLoginResponseDto(responseDto, timestamp: timestamp);
  }

  @override
  Future<AuthToken> refresh(String refreshToken) async {
    final DateTime timestamp = DateTime.now();
    final bearerTokenDto = BearerAuthorizationDto(refreshToken);
    final responseDto = await publicDataSource.post(
      pathToRefreshAccessToken,
      headers: bearerTokenDto,
      cancelable: cancelable,
      deserializer: BearerTokenResponseDto.fromJson,
    );
    return _authTokenFromBearerResponseTokenDto(
      responseDto,
      timestamp: timestamp,
    );
  }

  @override
  Future<void> generateOneTimePassword({
    required String deviceIdentifier,
    required String userAgent,
  }) =>
      privateDataSource.post(
        pathToGenerateOTP,
        headers: UserAgentDto(userAgent: userAgent),
        body: DeviceDto(deviceIdentifier: deviceIdentifier),
        cancelable: cancelable,
      );

  @override
  Future<AuthToken> authenticate(
    String oneTimePassword, {
    required String deviceIdentifier,
    required String userAgent,
  }) async {
    final DateTime timestamp = DateTime.now();
    final twoFactorAuthenticationDto = TwoFactorAuthenticationCodeDto(
      confirmationCode: oneTimePassword,
      deviceIdentifier: deviceIdentifier,
    );
    final responseDto = await privateDataSource.post(
      pathForTwoStepLogin,
      headers: UserAgentDto(userAgent: userAgent),
      body: twoFactorAuthenticationDto,
      cancelable: cancelable,
      deserializer: BearerTokenResponseDto.fromJson,
    );
    return _authTokenFromBearerResponseTokenDto(
      responseDto,
      timestamp: timestamp,
    );
  }
}

/// Map [LoginResponseDto] to [AuthToken].
/// [timestamp] is used to get expiration [DateTime] from
/// [LoginResponseDto.expiresIn].
AuthToken _authTokenFromLoginResponseDto(
  LoginResponseDto value, {
  required DateTime timestamp,
}) {
  final duration = Duration(seconds: value.expiresIn);
  final expiresAt = timestamp.add(duration);

  return AuthToken(
    id: value.id,
    accessToken: value.accessToken,
    expiresInDate: expiresAt,
    refreshToken: value.refreshToken,
    needTFA: value.needsTwoFactorVerification,
  );
}

/// Map [BearerTokenResponseDto] to [AuthToken].
/// [timestamp] is used to get expiration [DateTime] from
/// [BearerTokenResponseDto.expiresIn].
AuthToken _authTokenFromBearerResponseTokenDto(
  BearerTokenResponseDto value, {
  required DateTime timestamp,
}) {
  final duration = Duration(seconds: value.expiresIn);
  final expiresAt = timestamp.add(duration);

  return AuthToken(
    id: value.id,
    accessToken: value.accessToken,
    expiresInDate: expiresAt,
    refreshToken: value.refreshToken,
    needTFA: false,
  );
}
