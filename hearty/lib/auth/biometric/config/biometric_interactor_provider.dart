import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../account/credentials_service.dart';
import '../credential_request_use_case.dart';
import '../impl/biometric_interactor.dart';
import 'biometric_service_provider.dart';

/// Provides the [BiometricInteractor] instance.
final biometricInteractorProvider =
    Provider.autoDispose<CredentialRequestUseCase>(
  (ref) => BiometricInteractor(
    ref.read(biometricServiceProvider),
    ref.read(credentialsServiceProvider),
  ),
);
