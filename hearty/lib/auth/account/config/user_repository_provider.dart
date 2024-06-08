import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../ports/user_repository.dart';
import '../rest/user_repository_api_adapter.dart';

/// Provides an instance of the [UserRepository].
final userRepositoryProvider = Provider.autoDispose<UserRepository>((ref) {
  final publicApi = ref.watch(publicApiProvider);
  final privateApi = ref.watch(privateApiProvider);

  final userRepository = UserRepositoryApiAdapter(
    publicApi,
    privateApi,
    HttpCancelToken(),
  );

  // TODO: [STT-1677] Observe changes for repositories and all derived providers
  // At the moment this provider disposes just after instantiating.
  // Please uncomment the below line when it's fixed.
  //    ref.onDispose(authRepository.dispose);
  return userRepository;
});
