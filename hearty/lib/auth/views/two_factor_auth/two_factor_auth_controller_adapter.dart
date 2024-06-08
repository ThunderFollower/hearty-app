import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../guide/guide.dart';
import '../../../legal_document/legal_document/document_status.dart';
import '../../../legal_document/legal_document/legal_document_status_use_case.dart';
import '../../../legal_document/legal_document/resolve_document_status_use_case.dart';
import '../../auth.dart';
import '../sign_up/second_step/controller/notifications/successful_password_creation_notification.dart';
import 'code/code_controller.dart';
import 'code/constants.dart';
import 'code/device_authentication_phase.dart';
import 'two_factor_auth_controller.dart';

/// Encapsulates the logic for the two-factor authentication process.
class TwoFactorAuthControllerAdapter extends TwoFactorAuthController
    implements CodeController {
  final TwoFactorAuthService twoFactorAuthService;

  /// Route to use for navigation.
  final StackRouter router;

  @override
  final TextEditingController editController;
  @override
  final FocusNode focusNode;

  final LegalDocumentStatusUseCase documentUseCase;

  final ResolveDocumentStatusUseCase resolveDocumentStatusUseCase;

  final OnboardingGuideService onboardingGuideService;

  /// The duration of the countdown timer in 1-second ticks.
  final int durationInTicks;

  Timer? _timer;

  /// A abstract command to open an email application.
  final OpenEmailAppUseCase openEmailAppUseCase;

  /// A use case for displaying notifications.
  final ShowNotification showNotification;

  /// Creates a new instance of the [TwoFactorAuthControllerAdapter] class.
  TwoFactorAuthControllerAdapter(
    super.state,
    this.twoFactorAuthService,
    this.editController,
    this.focusNode,
    this.router,
    this.documentUseCase,
    this.resolveDocumentStatusUseCase,
    this.durationInTicks, {
    required this.mainRoute,
    required this.signInPath,
    required this.openEmailAppUseCase,
    required this.onboardingGuideService,
    required this.showNotification,
  }) {
    focusNode.addListener(handlePinCodeFocus);
    requestCode();
  }

  /// The main route of the application.
  final PageRouteInfo mainRoute;

  /// The path to sign-in page.
  final String signInPath;

  @override
  void dispose() {
    focusNode.removeListener(handlePinCodeFocus);
    _stopTimer();
    super.dispose();
  }

  @override
  Future<void> requestCode() async {
    if (_timer != null) return;

    await twoFactorAuthService.requestCode();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  @override
  Future<void> openMailApp() => openEmailAppUseCase.execute();

  @override
  Future<void> authenticate() async {
    // There is no sense in sending a PIN code if it's obviously either invalid
    // or checked.
    assert(
      state.phase == DeviceAuthenticationPhase.ready,
      'The authentication phase must be ready.',
    );

    // Updating the state to the validating phase mitigates resending requests.
    state = state.copyWith(phase: DeviceAuthenticationPhase.validating);

    try {
      // Clear the focus on the PIN-code field to hide the keyboard.
      // A user should tap it again to show the keyboard to enter a new PIN
      // code. It will clear the invalid PIN code.
      focusNode.nextFocus();

      await twoFactorAuthService.sendCode(code: editController.text);
      state = state.copyWith(phase: DeviceAuthenticationPhase.done);

      await router.replace(mainRoute);
    } on NotFoundException catch (_) {
      state = state.copyWith(phase: DeviceAuthenticationPhase.error);
    }
  }

  @override
  void updateCode(String code) {
    if (state.phase == DeviceAuthenticationPhase.error ||
        code.length < pinCodeLength) {
      // Clear the error state when entering a new PIN.
      state = state.copyWith(phase: DeviceAuthenticationPhase.pending);
    } else if (state.phase == DeviceAuthenticationPhase.pending &&
        code.length == pinCodeLength) {
      // PIN code is ready for submission.
      state = state.copyWith(phase: DeviceAuthenticationPhase.ready);
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _onTimerTick(Timer timer) async {
    if (!mounted) {
      return;
    }

    late int countdown;
    if (timer.tick >= durationInTicks) {
      _stopTimer();
      countdown = 0;
    } else {
      countdown = durationInTicks - timer.tick;
    }
    state = state.copyWith(countdown: countdown);
  }

  @protected
  Future<bool> isDocumentSigningRequired() async {
    final status = await documentUseCase.execute().first;
    return status != DocumentStatus.upToDate;
  }

  @protected
  Future<bool> isOnboardingGuideRequired() async {
    final stream = await onboardingGuideService
        .observeWasGuideViewedState()
        .take(1)
        .toList();

    if (stream.isEmpty) return true;

    return stream.first;
  }

  /// Handle focus changes of a PIN-code input field.
  void handlePinCodeFocus() {
    // Clear a PIN code if it is invalid. So a user can re-enter it.
    if (state.phase == DeviceAuthenticationPhase.error) {
      editController.clear();
    }
  }

  @override
  void navigateBack() {
    router.popUntilRoot();
    router.replaceNamed(signInPath);
  }

  @override
  void showSuccessNotification() {
    showNotification.execute(const SuccessfulPasswordCreationNotification());
  }
}
