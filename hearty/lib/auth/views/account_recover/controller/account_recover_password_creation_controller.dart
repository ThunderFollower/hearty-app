/// Defines the contract for the controller of the password creation screen.
abstract class AccountRecoverPasswordCreationController {
  /// Register the given [password] as user's password using
  /// the [securityToken].
  ///
  /// Returns a completed [Future].
  Future<void> register(String password, {required String securityToken});
}
