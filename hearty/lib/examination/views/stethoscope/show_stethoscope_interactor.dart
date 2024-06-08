import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/account/index.dart';
import '../../../core/core.dart';
import '../../examination.dart';
import '../connection/connection_controller.dart';
import 'stethoscope_sheet.dart';

/// A command that shows the stethoscope bottom sheet.
class ShowStethoscopeInteractor implements ShowStethoscopeUseCase {
  /// Creates a [ShowStethoscopeInteractor] with required dependencies.
  ShowStethoscopeInteractor(
    this._key,
    this._stethoscopeStateController,
    this._stethoscopeOpeningState,
    this._connectionController,
    this._authProfileService,
    this._signOut,
    this._router,
  );

  // A key that is used to access a context.
  final GlobalKey _key;
  // A controller that is used to set the stethoscope mode state.
  final StateController<StethoscopeMode> _stethoscopeStateController;
  // A controller that is used to track the stethoscope opening state.
  final StateController<bool> _stethoscopeOpeningState;
  // A controller that is used to check the connectivity before opening the
  // stethoscope.
  final ConnectionController _connectionController;

  /// An instance of the `AuthProfileService` class.
  /// This service is responsible for handling user authentication profiles.
  final AuthProfileService _authProfileService;

  /// The command to perform the sign out operation.
  final AsyncCommand<bool> _signOut;

  final StackRouter _router;

  @override
  Future<void> execute({
    StethoscopeMode mode = StethoscopeMode.listening,
    String? recordId,
  }) async {
    if (mode == StethoscopeMode.recording &&
        await _authProfileService.refreshCurrentUser() == null) {
      await _signOut.execute();
      return;
    }

    return _showStethoscope(
      stateController: _stethoscopeStateController,
      openingStateController: _stethoscopeOpeningState,
      connectionController: _connectionController,
      mode: mode,
      router: _router,
      recordId: recordId,
    );
  }

  /// Shows the stethoscope bottom sheet.
  Future<void> _showStethoscope({
    required StateController<StethoscopeMode> stateController,
    required StateController<bool> openingStateController,
    required ConnectionController connectionController,
    required StethoscopeMode mode,
    required StackRouter router,
    String? recordId,
  }) async {
    if (openingStateController.state) return;

    stateController.state = mode;
    openingStateController.state = true;

    if (mode == StethoscopeMode.recording) {
      await _navigateToStethoscopeRoute(recordId);
    } else {
      await _showModalStethoscope(recordId);
    }

    openingStateController.state = false;

    await connectionController.checkConnectivity();
  }

  Future<T?> _navigateToStethoscopeRoute<T>([String? recordId]) async {
    final uri = stethoscopePathResolver(recordId);
    if (_router.currentPath != uri.path) return _router.pushNamed('$uri');
    return null;
  }

  /// Shows the modal stethoscope bottom sheet.
  Future<T?> _showModalStethoscope<T>([String? recordId]) {
    final context = _key.currentContext;
    assert(context != null);
    if (context == null) return Future.value();
    return showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => StethoscopeSheet(recordId: recordId),
    );
  }
}
