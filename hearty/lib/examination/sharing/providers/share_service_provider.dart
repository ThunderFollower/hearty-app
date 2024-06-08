import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../impl/share_service_adapter.dart';
import '../share_service.dart';
import 'share_repository_provider.dart';

/// Provides a mediator for the sharing domain model.
final shareServiceProvider = Provider<ShareService>(
  (ref) {
    final shareServiceAdapter = ShareServiceAdapter(
      ref.read(shareRepositoryProvider),
    );
    ref.onDispose(shareServiceAdapter.dispose);
    return shareServiceAdapter;
  },
);
