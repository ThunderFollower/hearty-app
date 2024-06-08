part of 'open_email_app_interactor.dart';

/// A widget that displays a popup action sheet for selecting an email application.
///
/// This popup is used when there are multiple email applications available and the
/// user needs to choose one to proceed with opening or composing an email.
class _Popup extends StatelessWidget {
  final List<MailApp> applications;
  final VoidCallback onDismiss;
  final String? mailTo;

  /// Creates an instance of [_Popup].
  ///
  /// Requires [applications] list to display the available email apps and [onDismiss] callback
  /// to handle the action when the popup is dismissed.
  /// Optionally takes a [mailTo] parameter to specify the recipient's email address.
  const _Popup({
    required this.applications,
    required this.onDismiss,
    this.mailTo,
  });

  @override
  Widget build(BuildContext context) => CupertinoActionSheet(
        title: const Text(LocaleKeys.OpenEmailInteractorPopup_Title).tr(),
        message: const Text(LocaleKeys.OpenEmailInteractorPopup_Message).tr(),
        actions: _buildActions(),
        cancelButton: _buildCancelButton(),
      );

  List<Widget> _buildActions() =>
      applications.map(_buildActionForSpecificApp).toList();

  Widget _buildActionForSpecificApp(MailApp app) => CupertinoActionSheetAction(
        child: Text(app.name).tr(),
        onPressed: () => _onPressed(mailTo, app),
      );

  Widget _buildCancelButton() => CupertinoActionSheetAction(
        onPressed: onDismiss,
        child: const Text(LocaleKeys.Cancel).tr(),
      );

  /// Handles the action when an email application is selected from the popup.
  ///
  /// Opens or composes a new email in the selected [app]. If [mailTo] is provided,
  /// it pre-fills the recipient's email address.
  Future<void> _onPressed(String? mailTo, MailApp app) async {
    if (mailTo != null) {
      final emailContent = EmailContent(to: [mailTo]);
      await OpenMailApp.composeNewEmailInSpecificMailApp(
        mailApp: app,
        emailContent: emailContent,
      );
    } else {
      await OpenMailApp.openSpecificMailApp(app);
    }
    onDismiss.call();
  }
}
