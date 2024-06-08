import 'package:logger/logger.dart';

import '../../account/credentials_service.dart';
import '../../account/entities/credentials.dart';
import '../biometric_service.dart';
import '../credential_request_use_case.dart';

/// Encapsulates the application's business logic for biometric authentication.
class BiometricInteractor extends CredentialRequestUseCase {
  /// Construct a new [BiometricInteractor] instance.
  BiometricInteractor(this.biometricService, this.credentialsService);

  /// The [BiometricService] to use for biometric authentication.
  final BiometricService biometricService;

  /// The [CredentialsService] to use for saving credentials.
  final CredentialsService credentialsService;

  /// The [Logger] to use for logging.
  final Logger logger = Logger();

  @override
  Future<List<Credentials>> execute() async {
    /// Check if biometric authentication is available.
    /// Attempt to authenticate with biometrics. If successful,
    /// return the known credentials.
    if (!await credentialsService.hasCredentials() || !await _isEnabled()) {
      return [];
    }

    try {
      await biometricService.authenticate();
      return credentialsService.load().first;
    } catch (error) {
      logger.e(error);
      return [];
    }
  }

  Future<bool> _isEnabled() async =>
      (await biometricService.observeBiometricChanges().first).isEnabled;
}
