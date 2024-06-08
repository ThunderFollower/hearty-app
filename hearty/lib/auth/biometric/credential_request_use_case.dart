import '../auth.dart';

/// Defines the use case for requesting account credentials.
abstract class CredentialRequestUseCase {
  /// Requests a credential.
  ///
  /// Returns a [Future] that completes with a list of account credentials.
  Future<List<Credentials>> execute();
}
