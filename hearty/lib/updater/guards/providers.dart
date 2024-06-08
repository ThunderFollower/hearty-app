import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../update/update.dart';
import 'update_guard.dart';

/// Provides an auto-disposable [AutoRouteGuard] for navigation update checks.
///
/// This provider creates an instance of [UpdateGuard].
final updateGuardProvider = Provider.autoDispose<AutoRouteGuard>(
  (ref) {
    final updateGuard = UpdateGuard(
      updateService: ref.watch(updateServiceProvider),
      logger: Logger(),
    );

    ref.onDispose(updateGuard.dispose);
    ref.keepAlive();

    return updateGuard;
  },
);
