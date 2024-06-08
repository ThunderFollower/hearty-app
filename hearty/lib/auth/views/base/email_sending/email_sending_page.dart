import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import 'email_send_body_container.dart';
import 'email_sending_controller.dart';
import 'email_sending_countdown_provider.dart';

const errorDescription = {
  BadRequestException.httpErrorCode: 'Invalid email address',
};

/// Defines an abstract class of an information page asking a user
/// to check for an email or request it again.
/// The email will be sent to the address specified in the [email] property.
///
/// The page has a [title] and the main body [text].
///
/// Derived classes should implement the [controllerProvider] property.
///
/// It sends a new request at initializing stage
/// if the countdown timer is not activated.
///
/// This page mitigates multiple clicks on buttons. It does not let send
/// an email or open an email client when a related operation is
/// already processing.
abstract class EmailSendingPage extends ConsumerStatefulWidget {
  /// The tittle of the page.
  final String title;

  /// The main body text, content.
  final String text;

  /// The title of the back button.
  final String backButtonTitle;

  /// The email address to sign up for a new account.
  final String email;

  /// Get a provider of the [EmailSendingController] from the [ProviderScope].
  ProviderBase<EmailSendingController> get controllerProvider;

  /// Create and initialize [EmailSendingPage] with the given [email].
  const EmailSendingPage(
    this.email, {
    super.key,
    required this.title,
    required this.text,
    required this.backButtonTitle,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmailSendPageState();
}

/// The state of [EmailSendingPage].
class _EmailSendPageState extends ConsumerState<EmailSendingPage> {
  /// The callback is called on the back button tap.
  VoidCallback? onBack;

  /// The callback is called on the resend button tap.
  VoidCallback? onResend;

  /// The callback is called on the email button tap.
  VoidCallback? onOpenEmailApp;

  @override
  void initState() {
    super.initState();
    final controller = ref.read(widget.controllerProvider);
    final countdownTimer = ref.read(emailSendingCountdownProvider.notifier);

    onBack = controller.navigateBack;
    onResend = execute;
    onOpenEmailApp = openEmailClient;

    // Mitigates forcibly resending the email by reopening this page
    // before ending the countdown timer.
    if (!countdownTimer.isActive) {
      /// The first request to the server to reset the password should be sent
      /// when opening the page. The resend should be locked at the opening.
      onResend = null;
      execute();
    }
  }

  @override
  Widget build(BuildContext context) => AppScaffold(
        backgroundColor: Colors.pink.shade100,
        appBar: TitleBar.withBackButton(widget.title, leading: Container()),
        body: buildBody(),
      );

  Widget buildBody() => EmailSendBodyContainer(
        text: widget.text,
        backButtonTitle: widget.backButtonTitle,
        onBack: onBack,
        onResend: onResend,
        onOpenEmailApp: onOpenEmailApp,
      );

  /// Execute the request to the server to reset the password.
  Future<void> execute() async {
    try {
      // We should not update the state if the controller is executing.
      // Initially the executing state is true.
      if (onResend != null) {
        setState(() => onResend = null);
      }

      final controller = ref.read(widget.controllerProvider);
      await controller.execute(widget.email);
    } on HttpException catch (error) {
      final errorText = errorDescription[error.statusCode] ??
          LocaleKeys.Server_error_Please_try_the_operation_again.tr();
      handlerError(errorText);
    } on Exception catch (error) {
      handlerError(error);
    } finally {
      setState(() => onResend = execute);
    }
  }

  /// Open the email client to send the email to the user.
  Future<void> openEmailClient() async {
    try {
      setState(() => onOpenEmailApp = null);
      final controller = ref.read(widget.controllerProvider);
      await controller.openEmailApp();
    } on Exception catch (error) {
      handlerError(error);
    } finally {
      setState(() => onOpenEmailApp = openEmailClient);
    }
  }

  /// Show the error message to the user.
  void handlerError(dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(
      DangerAlert.fromError(error),
    );
  }
}
