import '../../account/auth_profile_service.dart';
import '../auth_by_email_use_case.dart';

/// An interactor that encapsulates the use case of signing up using an email
/// address and password.
class SignUpByEmailInteractor implements AuthByEmailUseCase {
  /// Creates a new [SignUpByEmailInteractor] with the given [_service].
  ///
  /// The [_service] parameter is an instance of [AuthProfileService], which
  /// is used to manage authentication profiles.
  const SignUpByEmailInteractor(this._service);

  /// A service to manage authentication profiles.
  final AuthProfileService _service;

  @override
  Future<void> execute(String email, String password) =>
      _service.signUpByEmail(email.toLowerCase(), password);
}
