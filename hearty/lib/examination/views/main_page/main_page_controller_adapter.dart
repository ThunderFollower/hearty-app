import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/auth.dart';
import '../../../core/core.dart';
import '../../../utils/utils.dart';
import '../../sharing/index.dart';
import '../examination/examination_controller.dart';
import 'content/received/list/received_list_controller.dart';
import 'main_page_controller.dart';

/// Implements the [MainPageController] contract.
class MainPageControllerAdapter extends MainPageController
    with SubscriptionManager {
  /// Creates the controller for the main page that deals with system events.
  MainPageControllerAdapter({
    required this.shareService,
    required this.authProfileService,
    required this.router,
    required this.mainRoute,
    required this.usedLinkMessageRoute,
    required this.invalidLinkRoute,
    required this.examinationRoute,
    required this.biometricInitializer,
    required Future<SharedPreferences> asyncPreferences,
    required this.receivedListController,
    required this.examinationController,
    required this.showStethoscope,
  }) {
    _init(asyncPreferences);
    biometricInitializer.call();
    _initSubscription();
  }

  /// An instance of the [ShareService] used by this controller.
  final ShareService shareService;

  final AuthProfileService authProfileService;

  /// An instance of the [StackRouter] used by this controller.
  final StackRouter router;

  final PageRouteInfo mainRoute;
  final PageRouteInfo usedLinkMessageRoute;
  final PageRouteInfo invalidLinkRoute;
  final PageRouteInfo Function(String) examinationRoute;
  // TODO: loose coupling
  final ReceivedListController receivedListController;
  final ExaminationController examinationController;

  bool _shouldOpenStethoscopePhone = true;
  final Logger _logger = Logger();

  /// A function that inits a biometric functionality.
  final VoidCallback biometricInitializer;

  /// A command to show the stethoscope bottom sheet.
  final AsyncCommand showStethoscope;

  /// Dispose internal resources.
  void dispose() {
    cancelSubscriptions();
  }

  Future<void> _init(Future<SharedPreferences> asyncPreferences) async {
    final preferences = await asyncPreferences;
    // Saves that the first time login flag.
    await preferences.setBool(firstTimeAuthKey, false);
  }

  void _initSubscription() {
    final subscription = shareService.selectPending().listen(
          handlePendingShares,
        );
    addSubscription(subscription);

    authProfileService
        .observeProfileChanges()
        .take(1)
        .where((event) => event?.role == UserRole.doctor)
        .listen((_) => _scheduleStethoscope());
  }

  void _scheduleStethoscope() {
    Future<void>.delayed(Duration.zero, triggerStethoscope);
  }

  void triggerStethoscope() {
    if (_shouldOpenStethoscopePhone) {
      showStethoscope.execute();
    }
  }

  @override
  void handleDrawerChange({required bool opened}) {}

  Future<void> handlePendingShares(String id) async {
    _shouldOpenStethoscopePhone = false;
    try {
      await for (final examinationId in shareService.acquire(id)) {
        await receivedListController.refresh();
        await examinationController
            .init(id: examinationId)
            .whenComplete(() => _openExamination(examinationId));

        break;
      }
    } on ForbiddenException catch (error) {
      router.push(usedLinkMessageRoute);
      _logger.e(error);
    } catch (error) {
      router.push(invalidLinkRoute);
      _logger.e(error);
    }
  }

  void _openExamination(String examinationId) {
    router.push(examinationRoute(examinationId));
  }
}
