import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../account/index.dart';
import 'impl/auth_guard.dart';

/// Defines a provider for [AuthGuard] instance.
final authGuardProvider = Provider.autoDispose<AutoRouteGuard>(
  (ref) {
    // Retain this provider across configurations.
    ref.keepAlive();

    // Provide an AuthGuard instance.
    return AuthGuard(
      ref.watch(authProfileServiceProvider),
      ref.watch(showErrorNotificationProvider),
      path: '/auth',
    );
  },
);
