import '../../../auth.dart';

/// Defines the contract of a controller that allows the user to select an account.
abstract class ChooseAccountController {
  /// Returns a [Stream] that emits a list of all available accounts.
  Stream<List<Credentials>> allAccounts();

  /// Dismiss the dialog and return the given [credentials] to the caller.
  ///
  /// Returns a [Future] that completes when the dialog is dismissed.
  Future<void> dismiss([Credentials? credentials]);

  /// Remove the given [credentials] from the list of accounts.
  ///
  /// Returns a completed [Future].
  Future<void> removeAccount(Credentials credentials);
}
