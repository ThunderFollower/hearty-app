import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../ports/share_repository.dart';
import '../rest/share_repository_api_adapter.dart';

/// Provides an instance of the [ShareRepository].
final shareRepositoryProvider = Provider<ShareRepository>(
  (ref) => ShareRepositoryApiAdapter(
    ref.watch(privateApiProvider),
    HttpCancelToken(),
  ),
);
