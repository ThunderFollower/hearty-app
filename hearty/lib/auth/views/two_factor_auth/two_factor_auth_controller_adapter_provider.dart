import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../../guide/onboarding/config/onboarding_guide_service_provider.dart';
import '../../../legal_document/legal_document/config/legal_document_status_use_case_provider.dart';
import '../../../legal_document/legal_document/config/resolve_document_signature_use_case_provider.dart';
import '../../auth.dart';
import 'two_factor_auth_controller_adapter.dart';
import 'two_factor_auth_state.dart';

/// Provides the [TwoFactorAuthControllerAdapter].
final twoFactorAuthControllerAdapterProvider = StateNotifierProvider
    .autoDispose<TwoFactorAuthControllerAdapter, TwoFactorAuthState>(
  (ref) {
    final textEditingController = TextEditingController();
    final adapter = TwoFactorAuthControllerAdapter(
      TwoFactorAuthState(),
      ref.watch(twoFactorAuthServiceProvider),
      textEditingController,
      FocusNode(),
      ref.watch(routerProvider),
      ref.watch(legalDocumentStatusUseCaseProvider),
      ref.watch(resolveDocumentSignatureUseCaseProvider),
      Config.maxResendCodeTickCount,
      mainRoute: ref.watch(mainRouteProvider),
      signInPath: '/auth',
      openEmailAppUseCase: ref.watch(openEmailAppProvider),
      onboardingGuideService: ref.watch(onboardingGuideServiceProvider),
      showNotification: ref.watch(showSuccessNotificationProvider),
    );

    ref.onDispose(() {
      textEditingController.dispose();
    });

    return adapter;
  },
);
