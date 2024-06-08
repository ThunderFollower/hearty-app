import '../../sign_in/index.dart';
import '../entities/user.dart';
import '../password_setup_use_case.dart';
import '../ports/user_repository.dart';

class AccountRecoveryPasswordInteractor implements PasswordSetupUseCase {
  /// Create a new [AccountRecoveryPasswordInteractor] using the given
  /// [userRepository].
  const AccountRecoveryPasswordInteractor(
    this.userRepository,
    this.signInUseCase,
  );

  /// A repository to manager [User] entities by this interactor.
  final UserRepository userRepository;

  final AuthByEmailUseCase signInUseCase;

  @override
  Future<User> execute(
    String password, {
    required String securityToken,
  }) async {
    // Sign up with a password and then sign in.
    final user = await userRepository.recoverPassword(
      password,
      securityToken: securityToken,
    );
    await signInUseCase.execute(user.email, password);
    return user;
  }
}
