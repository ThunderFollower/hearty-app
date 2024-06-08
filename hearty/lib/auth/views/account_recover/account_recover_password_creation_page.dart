import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/index.dart';
import 'config/account_recover_password_creation_controller_provider.dart';

/// A page that allows the user to set up a new password after recovering their
/// account.
@RoutePage()
class AccountRecoverPasswordCreationPage extends ConsumerWidget {
  /// Creates a new instance of [AccountRecoverPasswordCreationPage] with the
  /// given [securityToken].
  const AccountRecoverPasswordCreationPage({
    @QueryParam('token') this.securityToken = '',
    @QueryParam('email') this.email = '',
  })  : assert(securityToken != '', 'Token must be provided.'),
        assert(email != 'Email must be provided.');

  /// The security token used to authenticate the user.
  final String securityToken;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the controller from the provider
    final provider = accountRecoverPasswordCreationControllerProvider(email);
    final controller = ref.watch(provider);

    // Return a PasswordCreationPage
    return PasswordCreationPage(
      notifierProvider: passwordValidationStateProvider.notifier,
      onSubmit: (password) => controller.register(
        password,
        securityToken: securityToken,
      ),
      email: email,
    );
  }
}
