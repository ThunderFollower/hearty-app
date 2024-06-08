import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/landing_state.dart';

/// Defines the contract for a controller of the landing page.
///
/// The controller has the responsibility of controlling actions and state on
/// the landing page, such as navigating to different pages,
/// opening the Help Center, and opening the stethoscope.
abstract class LandingController implements StateNotifier<LandingState> {
  /// Handles the action to open the Help Center.
  void openHelpCenter();

  /// Handles the action to open the sign-up page.
  void openSignUp();

  /// Handles the action to open the sign-in page.
  void openSignIn();

  /// Handles the action to open the stethoscope.
  void openStethoscope();

  /// Handles the action to open the Legal Documents page.
  void openLegalDocuments();
}
