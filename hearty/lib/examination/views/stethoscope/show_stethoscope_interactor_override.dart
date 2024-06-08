import 'dart:core';

import '../../../auth/auth.dart';
import '../../../core/core.dart';
import '../../../core/views.dart';
import '../connection/config/connection_controller_provider.dart';
import 'providers.dart';
import 'show_stethoscope_interactor.dart';

/// Overrides the [showStethoscopeProvider] to provide the
/// [ShowStethoscopeInteractor].
final showStethoscopeInteractorOverride = showStethoscopeProvider.overrideWith(
  (ref) => ShowStethoscopeInteractor(
    ref.read(navigatorKeyProvider),
    ref.watch(stethoscopeModeProvider.notifier),
    ref.watch(stethoscopeIsOpenProvider.notifier),
    ref.watch(connectionControllerProvider.notifier),
    ref.watch(authProfileServiceProvider),
    ref.watch(automaticSignOutProvider),
    ref.watch(routerProvider),
  ),
);
