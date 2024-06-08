import '../entities/user.dart';
import '../password_request_use_case.dart';
import '../ports/user_repository.dart';

///
/// See also [PasswordRequestUseCase].
///
/// ---
/// An interactor is a simple, single-purpose object.
/// Interactors are used to encapsulate the application's business logic.
/// Each interactor represents one thing that the application does.
class AccountRecoveryEmailInteractor implements PasswordRequestUseCase {
  /// A repository to manager [User] entities by this interactor.
  final UserRepository _userRepository;

  /// Create a new [AccountRecoveryEmailInteractor] using the given [_userRepository].
  const AccountRecoveryEmailInteractor(this._userRepository);

  @override
  Future<void> execute(String email) =>
      _userRepository.doPasswordReset(email.toLowerCase());
}
