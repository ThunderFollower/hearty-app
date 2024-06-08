import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_mail_app/open_mail_app.dart';

import '../../../generated/locale_keys.g.dart';
import 'open_email_app_use_case.dart';

part 'open_email_app_interactor_popup.dart';

/// Implements the [OpenEmailAppUseCase] to handle the process of opening
/// an email application and managing user choice if multiple applications are available.
class OpenEmailAppInteractor implements OpenEmailAppUseCase {
  /// The [GlobalKey] used to access the application's navigation context.
  final GlobalKey key;

  /// The [StackRouter] used for navigation within the app.
  final StackRouter router;

  OpenEmailAppInteractor({
    required this.key,
    required this.router,
  });

  @override
  Future<void> execute([String? mailTo]) async {
    final result = await open(mailTo);
    if (!result.didOpen && result.canOpen) {
      return chooseApplication(result.options, mailTo);
    }
  }

  /// Attempts to open an email application.
  ///
  /// Optionally takes a [mailTo] parameter to specify the recipient's email address.
  /// Returns an [OpenMailAppResult] with the result of the attempt.
  @protected
  Future<OpenMailAppResult> open([String? mailTo]) {
    if (mailTo == null) return OpenMailApp.openMailApp();

    final emailContent = EmailContent(to: [mailTo]);
    return OpenMailApp.composeNewEmailInMailApp(emailContent: emailContent);
  }

  /// Shows a popup to choose an email application from the provided [applications].
  ///
  /// Optionally takes a [mailTo] parameter if the email address is specified.
  /// Uses [router] for managing the popup dismissal.
  @protected
  Future<T?> chooseApplication<T>(
    List<MailApp> applications, [
    String? mailTo,
  ]) {
    final context = key.currentContext;
    assert(context != null);
    if (context == null) return Future.value();

    final popup = _Popup(
      applications: applications,
      onDismiss: router.pop,
      mailTo: mailTo,
    );

    return showCupertinoModalPopup(context: context, builder: popup.build);
  }
}
