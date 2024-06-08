import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../ports/index.dart';
import '../rest/auth_profile_api_repository.dart';

// Define a provider called `authProfileRepositoryProvider` that creates
// instances of `AuthProfileApiRepository`. This provider is set to auto-dispose
// when no longer needed.
final authProfileRepositoryProvider =
    Provider.autoDispose<AuthProfileRepository>(
  (ref) => AuthProfileApiRepository(
    ref.watch(publicApiProvider),
    ref.watch(privateApiProvider),
    HttpCancelToken(),
  ),
);
