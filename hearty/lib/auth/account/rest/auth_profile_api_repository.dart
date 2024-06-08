import '../../../core/core.dart';
import '../../common/index.dart';
import '../entities/auth_profile.dart';
import '../exceptions/index.dart';
import '../ports/index.dart';
import 'constants.dart';
import 'dtos/index.dart';

/// An implementation of [AuthProfileRepository] that communicates with the
/// remote API using REST.
///
/// This repository handles signing up users, deleting user profiles, and
/// refreshing access and refresh tokens.
class AuthProfileApiRepository implements AuthProfileRepository {
  /// Constructs a new adapter that uses the given [_publicDataSource] for API
  /// requests and [_privateDataSource] for authenticated API requests.
  ///
  /// The [_cancelable] parameter is used to cancel API requests when they are
  /// no longer needed.
  const AuthProfileApiRepository(
    this._publicDataSource,
    this._privateDataSource,
    this._cancelable,
  );

  /// A data source object to access public API.
  final HttpDataSource _publicDataSource;

  /// A data source object to access private API.
  final HttpDataSource _privateDataSource;

  /// A cancelable object to cancel API requests.
  final Cancelable _cancelable;

  @override
  Future<AuthProfile> signUpByEmail(String email, String password) async {
    try {
      final response = await _publicDataSource.post(
        signUpByEmailPath,
        body: RegisterUserByEmailDto(email: email, password: password),
        cancelable: _cancelable,
        deserializer: RegisterUserByEmailResponseDto.fromJson,
      );

      return AuthProfile(
        id: response.id,
        email: email,
        password: password,
        expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    } on ConflictException catch (e) {
      throw SignUpException('Failed to sign up: $e');
    }
  }

  @override
  Future<void> deleteProfile() =>
      _privateDataSource.delete<void>(currentProfilePath);

  @override
  Future<AuthProfile> refresh(AuthProfile profile) async {
    final response = await _publicDataSource.post(
      authenticationRefresh,
      headers: BearerAuthorizationDto(profile.refreshToken!),
      cancelable: _cancelable,
      deserializer: RefreshResponseDto.fromJson,
    );

    return profile.copyWith(
      expiresAt: DateTime.now().add(Duration(seconds: response.expiresIn)),
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }
}
