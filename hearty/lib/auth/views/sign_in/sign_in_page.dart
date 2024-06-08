import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'buttons/index.dart';
import 'login_form/login_form.dart';
import 'sign_in_controller.dart';
import 'sign_in_controller_provider.dart';
import 'sign_in_geometry.dart';
import 'sign_in_scaffold.dart';
import 'sign_in_state.dart';

/// Defines a page that allows the user to sign in.
@RoutePage()
class SignInPage extends ConsumerWidget {
  const SignInPage({
    super.key,
    @QueryParam('initial') this.isInitialAuthentication = false,
  });

  /// A flag indicating whether the Sign-In screen is being shown as part of the
  /// initial sign-in process, or if it is being shown for re-authentication or
  /// sign-out. This can be used to customize the behavior of the screen, such
  /// as showing different messages or hiding certain controls. Defaults to
  /// `false`.
  final bool isInitialAuthentication;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = signInControllerProvider(isInitialAuthentication);
    final state = ref.watch(provider);
    final controller = ref.watch(provider.notifier);

    // Layouts
    final layout = SignInGeometry.of(context);
    final column = Column(
      children: [
        SizedBox(height: layout.appBarPadding),
        _buildLoginForm(controller, state),
        SizedBox(height: layout.textButtonMargin),
        _buildForgotPassword(controller, state),
        SizedBox(height: layout.bottomPadding),
      ],
    );

    final focusScope = FocusScope.of(context);

    final scaffold = SignInScaffold(
      body: column,
      onPressed: controller.back,
    );
    return SizedBox(
      height: layout.height,
      child: GestureDetector(onTap: focusScope.unfocus, child: scaffold),
    );
  }

  Widget _buildLoginForm(SignInController controller, SignInState state) {
    final onSubmit = state.isEnabled ? controller.authenticateWithEmail : null;
    return LoginForm(onSubmit: onSubmit);
  }

  Widget _buildForgotPassword(SignInController controller, SignInState state) {
    final onPressed = state.isEnabled ? controller.recoverAccount : null;
    return ForgotPasswordButton(onPressed: onPressed);
  }
}
