import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../core/views/info_dialog/index.dart';
import '../../../guide/onboarding/config/onboarding_guide_service_provider.dart';
import '../../../legal_document/legal_document/config/legal_document_status_use_case_provider.dart';
import '../../../legal_document/legal_document/config/resolve_document_signature_use_case_provider.dart';

import '../../auth.dart';
import '../../biometric/config/biometric_interactor_provider.dart';
import '../../biometric/config/biometric_service_provider.dart';
import 'helper/helper.dart';
import 'sign_in_controller.dart';
import 'sign_in_controller_adapter.dart';
import 'sign_in_state.dart';

/// Provides the sign-in controller.
final signInControllerProvider = StateNotifierProvider.family
    .autoDispose<SignInController, SignInState, bool>(
  (ref, isInitialAuthentication) => SignInControllerAdapter(
    const SignInState(),
    ref.watch(routerProvider),
    ref.watch(signInInteractorProvider),
    ref.watch(biometricInteractorProvider),
    ref.watch(tokenService),
    ref.watch(legalDocumentStatusUseCaseProvider),
    ref.watch(resolveDocumentSignatureUseCaseProvider),
    Logger(),
    ref.watch(showInfoDialogProvider),
    ref.watch(openHelpCenterProvider),
    ref.watch(showStethoscopeProvider),
    ref.read(sharedPreferencesProvider.future),
    ref.watch(onboardingGuideServiceProvider),
    ref.watch(biometricServiceProvider),
    ref.watch(showErrorNotificationProvider),
    mainRoutePath: '/home',
    signUpPath: '/sign-up',
    twoFactorAuthPath: twoFactorAuthPath,
    accountRecoveryPath: '/recovery',
    isInitialAuthentication: isInitialAuthentication,
    signInHelper: ref.watch(signInHelperProvider),
  ),
);
