import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/index.dart';
import 'config/sign_up_second_step_controller_provider.dart';

/// A page that allows users to create a password for a new account.
@RoutePage()
class SignUpSecondStepPage extends ConsumerWidget {
  /// Creates a new instance of [SignUpSecondStepPage].
  ///
  /// The [email] parameter is used to authenticate the user.
  ///
  /// Throws an [AssertionError] if the [email] parameter is `null`.
  const SignUpSecondStepPage({
    @queryParam String? email,
  })  : assert(email != null, 'Email should be specified'),
        email = email ?? '';

  /// The user's email.
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the controller from the provider.
    final provider = signUpSecondStepControllerProvider(email);
    final controller = ref.watch(provider);

    // Return a PasswordCreationPage widget.
    return PasswordCreationPage(
      notifierProvider: passwordValidationStateProvider.notifier,
      onSubmit: controller.createUser,
      email: email,
    );
  }
}
