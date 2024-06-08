import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../ports/auth_token_repository.dart';
import '../rest/auth_token_repository_api_adapter.dart';

/// Provides an instance of the [AuthTokenRepository].
final authTokenRepositoryProvider =
    Provider.autoDispose<AuthTokenRepository>((ref) {
  final publicApi = ref.watch(publicApiProvider);
  final privateApi = ref.watch(privateApiProvider);
  final authRepository = AuthTokenRepositoryApiAdapter(
    publicApi,
    privateApi,
    HttpCancelToken(),
  );

  // TODO: [STT-1677] Observe changes for the AuthRepository and all derived providers
  // At the moment this provider disposes just after instantiating.
  // Please uncomment the below line when it's fixed.
  //    ref.onDispose(authRepository.dispose);
  return authRepository;
});
