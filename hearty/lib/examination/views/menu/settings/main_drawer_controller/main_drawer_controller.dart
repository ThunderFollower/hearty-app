import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_drawer_state.dart';

abstract class MainDrawerController extends StateNotifier<MainDrawerState> {
  MainDrawerController(super.state);

  void openLegalPage();
  void openFeedbackPage();
  void openUserGuidesPage();
  void openAppLanguageSettings();
  void showDeclickerInfo();
  void showDoctorModeInfo();

  /// Opens the Help Center.
  void openHelpCenter();

  /// Switches the doctor mode.
  void switchDoctorMode();

  /// Enables or disables biometric.
  void switchBiometricState();

  /// Enables or disables microphone.
  void switchMicrophoneState();

  /// Enables or disables location.
  void switchLocationState();

  /// Signs out the current user.
  void signOut();
}
