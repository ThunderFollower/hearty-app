import '../credentials_service.dart';
import '../password_request_use_case.dart';

/// Defines the application's business logic for forgetting a user password.
class ForgotPasswordInteractor extends PasswordRequestUseCase {
  /// Construct a new [ForgotPasswordInteractor] instance with
  /// the provided [CredentialsService].
  ForgotPasswordInteractor(this.credentialsService);

  /// The credentials service.
  final CredentialsService credentialsService;

  /// Forgot a password for the given [email].
  ///
  /// Returns a [Future] that completes.
  @override
  Future<void> execute(String email) => credentialsService.remove(login: email);
}
