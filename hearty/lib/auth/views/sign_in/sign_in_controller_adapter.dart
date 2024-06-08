import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../guide/guide.dart';
import '../../../legal_document/legal_document/index.dart';
import '../../../legal_document/legal_document/resolve_document_status_use_case.dart';
import '../../../utils/utils.dart';
import '../../auth.dart';
import '../../biometric/biometric_service.dart';
import '../../biometric/credential_request_use_case.dart';
import 'choose_account/choose_account_dialog.dart';
import 'helper/sign_in_helper.dart';
import 'sign_in_controller.dart';
import 'sign_in_state.dart';

/// Implements the [SignInController] interface.
class SignInControllerAdapter extends StateNotifier<SignInState>
    with SubscriptionManager
    implements SignInController {
  /// Creates a new instance of the controller.
  SignInControllerAdapter(
    super.state,
    this._router,
    this._signIn,
    this._biometric,
    this._tokenService,
    this._documentUseCase,
    this._resolveDocumentStatusUseCase,
    this._logger,
    this._showAlert,
    this._openHelpCenter,
    this._showStethoscope,
    this._asyncPreferences,
    this._onboardingGuideService,
    BiometricService biometricService,
    this._showErrorNotification, {
    required this.mainRoutePath,
    required this.signUpPath,
    required this.twoFactorAuthPath,
    required this.accountRecoveryPath,
    required this.isInitialAuthentication,
    required this.signInHelper,
  }) {
    if (state.isEnabled) {
      biometricService
          .listenBiometricsRequest()
          .listen(_onBiometricsRequest)
          .addToList(this);

      _invalidateState();
    }
  }

  /// The router to use for navigation.
  final StackRouter _router;

  /// The use case to execute for signing in.
  final AuthByEmailUseCase _signIn;

  /// The use case to execute for biometric authentication.
  final CredentialRequestUseCase _biometric;

  /// The service to use for token management.
  final TokenService _tokenService;

  final LegalDocumentStatusUseCase _documentUseCase;

  final ResolveDocumentStatusUseCase _resolveDocumentStatusUseCase;

  final OnboardingGuideService _onboardingGuideService;

  /// A logger instance to log messages during the sign-in process.
  final Logger _logger;

  /// Showing an alert dialog.
  final ShowAlertUseCase _showAlert;

  /// A command to open the help center in the default browser or app.
  final AsyncCommand _openHelpCenter;

  /// A command to show the stethoscope bottom sheet.
  final AsyncCommand _showStethoscope;

  /// A future that returns the [SharedPreferences] instance for this app.
  final Future<SharedPreferences> _asyncPreferences;

  /// A use case for displaying error notifications.
  final ShowNotification _showErrorNotification;

  /// The path to the main route of the application.
  final String mainRoutePath;

  /// The path to the sign up page.
  final String signUpPath;

  /// The path to the 2FA.
  final String twoFactorAuthPath;

  /// The path to the account recovery path.
  final String accountRecoveryPath;

  /// A flag indicating whether the Sign-In screen is being shown as part of the
  /// initial sign-in process, or if it is being shown for re-authentication or
  /// sign-out.
  final bool isInitialAuthentication;

  final SignInHelper signInHelper;

  /// Returns a future that resolves to a boolean indicating whether this is
  /// the first time the user has authenticated.
  Future<bool> get _isFirstTimeAuth async =>
      (await _asyncPreferences).getBool(firstTimeAuthKey) ?? true;

  /// Invalidates the state of the controller.
  Future<void> _invalidateState() async {
    final isFirstTimeAuth = await _isFirstTimeAuth;
    state = state.copyWith(canOpenStethoscope: !isFirstTimeAuth);

    if (isInitialAuthentication && await _wasOpenedByLink) return;
    authenticateWithBiometric();
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  void _onBiometricsRequest([dynamic _]) {
    authenticateWithBiometric();
  }

  @override
  Future<void> back() async {
    _router.popUntilRouteWithPath(landingPath);
    try {
      if (_router.currentPath != landingPath) {
        await _router.replaceNamed(landingPath);
      }
    } catch (error, stackTrace) {
      _logger.e('$this failed to navigate back', error, stackTrace);
    }
  }

  @override
  Future<void> recoverAccount() async {
    state = state.copyWith(isEnabled: false);

    try {
      await _router.pushNamed(accountRecoveryPath);
    } catch (e, stackTrace) {
      _logger.e('Cannot get password recovery', e, stackTrace);
    } finally {
      state = state.copyWith(isEnabled: true);
    }
  }

  @override
  void openHelpCenter() {
    _openHelpCenter.execute();
  }

  @override
  Future<void> signUp() async {
    state = state.copyWith(isEnabled: false);

    try {
      await _router.pushNamed(signUpPath);
    } catch (e, stackTrace) {
      _logger.e('Cannot start the sign-up', e, stackTrace);
    } finally {
      state = state.copyWith(isEnabled: true);
    }
  }

  @override
  Future<void> authenticateWithBiometric() async {
    state = state.copyWith(isEnabled: false);

    try {
      final accounts = await _biometric.execute();
      if (accounts.isEmpty) return;

      final account = await _chooseAccount(accounts);
      if (account == null) return;
      await authenticateWithEmail(account.login, account.password);
    } catch (error, stackTrace) {
      _logger.e('$this: Biometric Authentication failed', error, stackTrace);
    } finally {
      if (mounted) state = state.copyWith(isEnabled: true);
    }
  }

  Future<bool> get _wasOpenedByLink async =>
      await signInHelper.hasLaunchOptions() ?? false;

  Future<Credentials?> _chooseAccount(Iterable<Credentials> accounts) async {
    final currentContext = _router.navigatorKey.currentContext;
    assert(currentContext != null);

    return accounts.length == 1
        ? accounts.single
        : await ChooseAccountDialog.showModal(currentContext!);
  }

  @override
  Future<void> authenticateWithEmail(String email, String password) async {
    state = state.copyWith(isEnabled: false);

    try {
      await _signIn.execute(email, password);
      TextInput.finishAutofillContext();
      await _navigateToNextRoute();
    } on UnauthorizedException catch (error, stackTrace) {
      _logger.e('Authentication failed', error, stackTrace);
      _showError(
        LocaleKeys.Invalid_credentials_Check_your_email_or_password.tr(),
      );
    } on TooManyRequestsException catch (error, stackTrace) {
      _logger.e('Authentication failed', error, stackTrace);
      _showRateLimitAlert();
    } catch (error, stackTrace) {
      _logger.e('Authentication failed', error, stackTrace);
      _showErrorNotification.execute(GenericErrorNotification(error));
    } finally {
      state = state.copyWith(isEnabled: true);
    }
  }

  void _showError(String errorMessage) {
    _showErrorNotification.execute(
      Text(errorMessage, textAlign: TextAlign.center, key: _loginErrorKey),
    );
  }

  void _showRateLimitAlert() {
    _showAlert.execute(title: LocaleKeys.Too_many_attempts_to_sign_in.tr());
  }

  /// Navigates to the next route based in the current application
  /// state.
  Future<void> _navigateToNextRoute() async {
    // Determine which route will be next based on current route
    String nextRouteName;
    if (await isTFARequired()) {
      nextRouteName = twoFactorAuthPath;
    } else {
      nextRouteName = mainRoutePath;
    }

    // Navigate to next route
    _replaceRoute(nextRouteName);
  }

  /// Replaces the current route with to the [path].
  Future<void> _replaceRoute(String path) async {
    try {
      _router.popUntilRoot();
      await _router.replaceNamed<void>(path);
    } catch (e, stackTrace) {
      _logger.e('Cannot finish the sign-in', e, stackTrace);
    }
  }

  @protected
  Future<bool> isTFARequired() async {
    final tokens = await _tokenService.get();
    return tokens?.needTFA ?? true;
  }

  @protected
  Future<bool> isDocumentSigningRequired() async {
    final status = await _documentUseCase.execute().first;
    return status != DocumentStatus.upToDate;
  }

  @protected
  Future<bool> isOnboardingGuideRequired() async {
    final stream = await _onboardingGuideService
        .observeWasGuideViewedState()
        .take(1)
        .toList();

    if (stream.isEmpty) return true;

    return stream.first;
  }

  @override
  Future<void> openStethoscope() async {
    try {
      state = state.copyWith(isEnabled: false);
      await _showStethoscope.execute();
    } finally {
      state = state.copyWith(isEnabled: true);
    }
  }
}

const _loginErrorKey = Key('loginError');
