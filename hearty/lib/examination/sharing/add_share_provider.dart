import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth.dart';
import '../../auth/biometric/config/biometric_service_provider.dart';
import 'add_share_use_case.dart';
import 'impl/add_share_interactor.dart';
import 'providers/share_service_provider.dart';

/// Defines the singleton instance of the [AddShareUseCase].
final addShareProvider = Provider.autoDispose<AddShareUseCase>(
  (ref) {
    final shareService = ref.watch(shareServiceProvider);
    final signOut = ref.watch(signOutProvider);
    final tokens = ref.watch(tokenService);
    final credentialsService = ref.watch(credentialsServiceProvider);

    final useCase = AddShareInteractor(
      shareService: shareService,
      signOut: signOut,
      tokenService: tokens,
      credentialsService: credentialsService,
      biometricService: ref.watch(biometricServiceProvider),
    );

    ref.onDispose(useCase.dispose);
    return useCase;
  },
);
