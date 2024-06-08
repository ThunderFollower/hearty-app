import '../../../core/core.dart';
import '../../common/index.dart';
import '../entities/user.dart';
import '../ports/user_repository.dart';
import 'constants.dart';
import 'dtos/email/email_dto.dart';
import 'dtos/password/password_dto.dart';
import 'dtos/user/user_response_dto.dart';

class UserRepositoryApiAdapter implements UserRepository {
  /// Construct a new adapter that uses the given [publicDataSource] and
  /// [privateDataSource] for HTTP requests.
  const UserRepositoryApiAdapter(
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
  Future<User> createUser(
    String password, {
    required String securityToken,
  }) =>
      publicDataSource.post(
        pathToRegister,
        queryParameters: TokenAuthorizationDto(token: securityToken),
        body: PasswordDto(password: password),
        cancelable: cancelable,
        deserializer: UserResponseDto.fromJson,
      );

  @override
  Future<void> doPasswordReset(String email) => publicDataSource.post(
        pathToResetPassword,
        body: EmailDto(email: email),
        cancelable: cancelable,
      );

  @override
  Future<User> getUser() => privateDataSource.post(
        pathToGetUser,
        cancelable: cancelable,
        deserializer: UserResponseDto.fromJson,
      );

  @override
  Future<User> recoverPassword(
    String password, {
    required String securityToken,
  }) =>
      publicDataSource.post(
        pathToRecoverPassword,
        headers: BearerAuthorizationDto(securityToken),
        body: PasswordDto(password: password),
        cancelable: cancelable,
        deserializer: UserResponseDto.fromJson,
      );

  @override
  Future<void> signUp(String email) => publicDataSource.post(
        pathToSignUpByEmail,
        body: EmailDto(email: email),
        cancelable: cancelable,
      );
}
