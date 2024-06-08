import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/layout.dart';
import 'widgets/log_in_button.dart';
import 'widgets/sign_up_button.dart';

/// Defines the landing page of the application.
///
/// This page is the first screen users usually see when they open the app.
@RoutePage()
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const LandingLayoutWidget(
        signUpButton: SignUpButtonWidget(),
        logInButton: LogInButtonWidget(),
      );
}
