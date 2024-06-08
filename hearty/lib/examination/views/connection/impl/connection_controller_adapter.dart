import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app_router.gr.dart';
import '../../../../auth/auth.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../examination.dart';
import '../../stethoscope/stethoscope_sheet.dart';
import '../connection_controller.dart';
import '../connectivity_state.dart';

typedef BoolCallback = bool Function();
typedef StethoscopeModeCallback = StethoscopeMode Function();

class ConnectionControllerAdapter extends ConnectionController {
  ConnectionControllerAdapter(
    this.router,
    this.isStethoscopeOpened,
    this.getStethoscopeMode,
    this.connectivity,
    this.asyncPreferences,
    this.signInRoutePath,
  ) : super(ConnectivityState());

  final StackRouter router;
  final BoolCallback isStethoscopeOpened;
  final StethoscopeModeCallback getStethoscopeMode;
  final Connectivity connectivity;
  final String signInRoutePath;

  /// A future that returns the [SharedPreferences] instance for this app.
  final Future<SharedPreferences> asyncPreferences;

  StreamSubscription? _connectivitySubscription;

  static final Logger _logger = Logger(printer: PrettyPrinter());

  @override
  Future<void> init() async {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = connectivity.onConnectivityChanged
        .listen(checkConnectivity, onError: _onError);

    checkConnectivity();
    router.addListener(checkIfOpen);
  }

  @override
  void dispose() {
    router.removeListener(checkIfOpen);
    super.dispose();
  }

  void _onError(Object error) {
    _logger.e(error);
  }

  @override
  Future<void> checkConnectivity([ConnectivityResult? _]) async {
    await checkIfUserIsAuthenticated();
    final stethoscopeOpened = isStethoscopeOpened();
    final isListening = getStethoscopeMode() == StethoscopeMode.listening;
    final connectivityResult = await connectivity.checkConnectivity();
    final isConnected = connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi;

    if (isConnected != state.isConnected) {
      state = state.copyWith(isConnected: isConnected);
    }

    if ((stethoscopeOpened && isListening) || isConnected || state.isOpen) {
      return;
    }

    setIsOpen();
    final connectionErrorRoute = ConnectionErrorRoute(
      imagePath: 'assets/images/connection_lost.svg',
      title: LocaleKeys.Check_your_internet_connection.tr(),
      description:
          LocaleKeys.Please_make_sure_you_re_connected_and_try_again.tr(),
      tryAgainTap: () => onErrorPageClose(isConnected: state.isConnected),
    );

    // To prevent connection error overlapping
    if (router.stack.any((e) => e.name == connectionErrorRoute.routeName)) {
      return;
    }

    router.push(connectionErrorRoute);
  }

  Future<void> onErrorPageClose({bool isConnected = true}) async {
    setIsOpen(isOpen: false);
    final routes = router.stack;
    // It means that the error route is the only one in the stack
    if (routes.length <= 1) {
      _navigateToSignInPage(isConnected);
    } else {
      router.popUntilRouteWithName(routes[routes.length - 2].name ?? '');
    }

    await checkConnectivity();
  }

  void _navigateToSignInPage(bool isConnected) {
    if (!isConnected) return;

    router.popUntilRoot();
    router.replaceNamed(signInRoutePath);
  }

  @override
  void setIsOpen({bool isOpen = true}) {
    state = state.copyWith(isOpen: isOpen);
  }

  void checkIfOpen() {
    if (!state.isOpen) return;
    final errorPageIsClosed = !router.stack.any(
      (element) => element.name == ConnectionErrorRoute.name,
    );
    if (errorPageIsClosed) setIsOpen(isOpen: false);
  }

  @override
  Future<void> checkIfUserIsAuthenticated() async {
    final isAuthenticated = !(await _isFirstTimeAuth);
    state = state.copyWith(isAuthenticated: isAuthenticated);
  }

  Future<bool> get _isFirstTimeAuth async =>
      (await asyncPreferences).getBool(firstTimeAuthKey) ?? true;

  @override
  void openStethoscope() {
    _showModalStethoscope();
  }

  /// Shows the modal stethoscope bottom sheet.
  Future<T?> _showModalStethoscope<T>() {
    final context = router.navigatorKey.currentState!.context;
    return showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (_) => const StethoscopeSheet(),
    );
  }
}
