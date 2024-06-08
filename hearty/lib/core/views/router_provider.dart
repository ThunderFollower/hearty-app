import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app_router.dart';
import '../../auth/auth.dart';
import '../../guide/views.dart';
import '../../purchases/purchases.dart';
import '../../updater/updater.dart';
import '../core.dart';

/// Provides an instance of [AppRouter].
final routerProvider = Provider<AppRouter>(
  (ref) => AppRouter(
    navigatorKey: ref.read(navigatorKeyProvider),
    welcomeGuideGuard: ref.read(welcomeGuideGuardProvider),
    authGuard: ref.read(authGuardProvider),
    subscriptionGuard: ref.read(subscriptionGuardProvider),
    updateGuard: ref.read(updateGuardProvider),
  ),
);
