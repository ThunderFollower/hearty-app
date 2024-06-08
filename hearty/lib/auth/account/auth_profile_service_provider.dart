import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../core/core.dart';
import '../authentication/token_service.dart';
import 'auth_profile_service.dart';
import 'config/auth_profile_repository_provider.dart';
import 'credentials_service.dart';
import 'impl/auth_profile_service_impl.dart';

// Define a provider called `authProfileServiceProvider` that creates
// instances of `AuthProfileServiceImpl`. This provider is set to auto-dispose
// when no longer needed.
final authProfileServiceProvider = Provider.autoDispose<AuthProfileService>(
  (ref) {
    final service = AuthProfileServiceImpl(
      ref.watch(authProfileRepositoryProvider),
      ref.read(emailProvider.notifier),
      ref.watch(credentialsServiceProvider),
      ref.watch(tokenService),
      ref.read(sharedPreferencesProvider.future),
      Logger(),
    );
    ref.onDispose(service.dispose);
    return service;
  },
);
