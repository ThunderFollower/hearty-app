import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'connectivity_state.dart';

/// Encapsulates exposing [ConnectivityState] view model.
abstract class ConnectionController extends StateNotifier<ConnectivityState> {
  ConnectionController(super.state);
  Future<void> init();
  Future<void> checkConnectivity([ConnectivityResult? _]);
  Future<void> checkIfUserIsAuthenticated();
  void setIsOpen({bool isOpen = true});
  void openStethoscope();
}
