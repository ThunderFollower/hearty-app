import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/providers/share_preferences_provider.dart';
import '../../../../core/views.dart';
import '../../stethoscope/index.dart';
import '../connection_controller.dart';
import '../connectivity_state.dart';
import '../impl/connection_controller_adapter.dart';
import 'connectivity_provider.dart';

/// Provides a connection's state.
final connectionControllerProvider =
    StateNotifierProvider<ConnectionController, ConnectivityState>(
  (ref) => ConnectionControllerAdapter(
    ref.watch(routerProvider),
    () => ref.read(stethoscopeIsOpenProvider),
    () => ref.read(stethoscopeModeProvider),
    ref.read(connectivityProvider),
    ref.read(sharedPreferencesProvider.future),
    '/auth',
  ),
);
