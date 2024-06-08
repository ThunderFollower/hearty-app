import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/core.dart';
import '../../../../account/constants.dart';
import '../../state/landing_state.dart';
import '../port/landing_controller.dart';

/// This is a state notifier and implements [LandingController] interface.
///
/// It handles business logic related to the landing page,
/// such as navigation, open help center, sign up, sign in, stethoscope and
/// legal documents.
class LandingControllerImpl extends StateNotifier<LandingState>
    implements LandingController {
  LandingControllerImpl(
    super.state,
    this._asyncPreferences,
    this._router,
    this._logger, {
    required this.showHelpCenter,
    required this.showStethoscope,
    required this.signUpPath,
    required this.logInPath,
    required this.documentsPath,
  }) {
    _invalidateState();
  }

  final Future<SharedPreferences> _asyncPreferences;
  final StackRouter _router;
  final Logger _logger;

  final AsyncCommand showHelpCenter;
  final AsyncCommand showStethoscope;
  final String signUpPath;
  final String logInPath;
  final String documentsPath;

  Future<bool> get _isFirstTimeAuth async =>
      (await _asyncPreferences).getBool(firstTimeAuthKey) ?? true;

  Future<void> _invalidateState() async {
    final isFirstTimeAuth = await _isFirstTimeAuth;
    state = state.copyWith(canOpenStethoscope: AsyncData(!isFirstTimeAuth));
  }

  @override
  void openHelpCenter() {
    showHelpCenter.execute();
  }

  @override
  void openLegalDocuments() {
    _pushRoute(documentsPath);
  }

  @override
  void openSignIn() {
    _pushRoute(logInPath);
  }

  @override
  void openSignUp() {
    _pushRoute(signUpPath);
  }

  @override
  void openStethoscope() {
    showStethoscope.execute();
  }

  Future<void> _pushRoute(String path) async {
    try {
      await _router.pushNamed(path);
    } catch (e, stackTrace) {
      _logger.e('Cannot push route $path', e, stackTrace);
    }
  }
}
