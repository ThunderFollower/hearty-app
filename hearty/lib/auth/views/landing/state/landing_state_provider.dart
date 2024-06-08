import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../../core/views.dart';
import '../controller/adapter/landing_controller_impl.dart';
import '../controller/port/landing_controller.dart';
import 'landing_state.dart';

/// Provides the state for the Landing page.
final landingStateProvider =
    StateNotifierProvider.autoDispose<LandingController, LandingState>(
  (ref) => LandingControllerImpl(
    const LandingState(),
    ref.read(sharedPreferencesProvider.future),
    ref.watch(routerProvider),
    Logger(),
    signUpPath: '/sign-up',
    logInPath: '/auth?initial=true',
    documentsPath: '/documents-list',
    showHelpCenter: ref.watch(openHelpCenterProvider),
    showStethoscope: ref.watch(showStethoscopeProvider),
  ),
);
