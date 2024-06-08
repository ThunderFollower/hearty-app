import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:logger/logger.dart';

import '../../core/core.dart';
import '../../utils/utils.dart';
import '../update/update.dart';

/// A navigation guard that checks for updates before proceeding with navigation.
///
/// It implements `AutoRouteGuard` to intercept navigation events and determine
/// if an update is necessary. If an update is required, it redirects to the
/// update screen; otherwise, it proceeds with the intended navigation.
class UpdateGuard with SubscriptionManager implements AutoRouteGuard {
  /// Creates an instance of [UpdateGuard].
  ///
  /// Requires [updateService] for checking updates and [logger] for logging errors.
  UpdateGuard({
    required this.updateService,
    required this.logger,
  });

  /// The service used to check for updates.
  final UpdateService updateService;

  /// Logger for error logging.
  final Logger logger;

  /// Disposes resources used by the guard, particularly by cancelling subscriptions.
  void dispose() {
    cancelSubscriptions();
  }

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    try {
      if (await _checkUpdate()) {
        // Navigates to the update screen if an update is necessary.
        if (router.canPop()) router.popUntilRoot();
        await router.replaceNamed(updatePath);
      } else {
        // Proceeds with the intended navigation if no update is required.
        resolver.next();
      }
    } catch (error, stackTrace) {
      logger.e('Update Guard failed', error, stackTrace);
      // Proceeds with the navigation in case of an error.
      resolver.next();
    }
  }

  /// Checks if an update is available.
  ///
  /// Listens for a single update event from [UpdateService] and completes the
  /// future with `true` if an update is necessary, otherwise `false`.
  ///
  /// Returns a [Future<bool>] indicating the presence of an update.
  Future<bool> _checkUpdate() async {
    final result = Completer<bool>();

    // Completes the completer with `false` when the stream is done
    // if it hasn't been completed yet.
    void handleDone() {
      if (!result.isCompleted) result.complete(false);
    }

    updateService
        .observeUpdate()
        .take(1)
        .listen(
          result.complete,
          onError: result.completeError,
          onDone: handleDone,
        )
        .addToList(this);

    return result.future;
  }
}
