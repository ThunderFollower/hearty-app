import 'package:flutter/material.dart';

import '../../../../core/views.dart';
import '../../sign_in/logo/app_logo.dart';

const _mainPadding = middleIndent;
const _buttonPadding = lowestIndent;
const _headerFlexFactor = 139;
const _bodyFlexFactor = 64;
const _footerFlexFactor = 88;

/// A layout widget for the landing page. This encapsulates the structure
/// of the landing page, including the header, body, and footer.
class LandingLayoutWidget extends StatelessWidget {
  const LandingLayoutWidget({
    super.key,
    required this.signUpButton,
    required this.logInButton,
  });

  final Widget signUpButton;
  final Widget logInButton;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        const SizedBox(height: statusBarIndent - _mainPadding),
        const Spacer(flex: _headerFlexFactor),
        const _Header(),
        const Spacer(flex: _bodyFlexFactor),
        _buildBody(),
        const Spacer(flex: _footerFlexFactor),
      ],
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: _wrap(content),
    );
  }

  Widget _buildBody() => _Body(
        signUpButton: signUpButton,
        logInButton: logInButton,
      );

  Widget _wrap(Widget widget) => Padding(
        padding: const EdgeInsets.all(_mainPadding),
        child: widget,
      );
}

/// A nested layout widget for the header of the landing page. This encapsulates
/// the structure of the landing's page header.
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => const AppLogo();
}

/// A nested layout widget for the body of the landing page. This encapsulates
/// the structure of the landing's page body with buttons.
class _Body extends StatelessWidget {
  const _Body({
    required this.signUpButton,
    required this.logInButton,
  });

  final Widget signUpButton;
  final Widget logInButton;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _buildSignUpButtonLayout(),
          _buildLogInButtonLayout(),
        ],
      );

  Widget _buildSignUpButtonLayout() => Padding(
        padding: const EdgeInsets.only(bottom: _buttonPadding),
        child: signUpButton,
      );

  Widget _buildLogInButtonLayout() => _wrapButton(logInButton);

  Widget _wrapButton(Widget button) => Padding(
        padding: const EdgeInsets.symmetric(vertical: _buttonPadding),
        child: button,
      );
}
