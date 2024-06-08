import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import 'email_entering_controller.dart';
import 'email_form/email_form.dart';

const _bodyPadding = EdgeInsets.symmetric(
  horizontal: middleIndent,
  vertical: belowMediumIndent,
);

/// Defines an abstract class of a page asking a user to enter an email address.
///
/// The page has a [title], the main body [text], and a submit button
/// with [submitText].
///
/// When a user enters an email address, the page will execute
/// the desired action.
/// Derived classes should implement the [controllerProvider] property
/// to specify the desired action.
///
/// This page mitigates multiple clicks on the submit button.
abstract class EmailEnteringPage extends ConsumerStatefulWidget {
  /// The initial email address.
  final String? initialEmail;

  /// The tittle of the page.
  final String title;

  /// The main body text, description.
  final String text;

  /// The text of the submit button.
  final String submitText;

  /// Create and initialize [EmailEnteringPage] with the given [title], [text],
  /// and [submitText].
  const EmailEnteringPage({
    required this.title,
    required this.text,
    required this.submitText,
    this.initialEmail,
  });

  /// Get a provider of the [EmailEnteringController] from the [ProviderScope].
  ProviderBase<EmailEnteringController> get controllerProvider;

  @override
  ConsumerState<EmailEnteringPage> createState() => _EmailEnterPageState();
}

/// The state of [EmailEnteringPage].
class _EmailEnterPageState extends ConsumerState<EmailEnteringPage> {
  ValueChanged<String>? onSubmitted;

  @override
  void initState() {
    super.initState();
    onSubmitted = submit;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AppScaffold(
        backgroundColor: Colors.pink.shade100,
        appBar: TitleBar.withBackButton(widget.title),
        body: _body(theme),
      ),
    );
  }

  /// The main body widget of the page.
  Widget _body(ThemeData theme) {
    return Padding(
      padding: _bodyPadding,
      child: _root(theme),
    );
  }

  /// The root widget of the page's body.
  Widget _root(ThemeData theme) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _description(theme),
          const Spacer(),
          EmailForm(
            initialEmail: widget.initialEmail,
            submitText: widget.submitText,
            onSubmitted: onSubmitted,
          ),
          const Spacer(flex: 2),
        ],
      );

  /// A widget with description text of the page.
  Widget _description(ThemeData theme) => Text(
        widget.text,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium,
      );

  /// The callback is called on the submit button tap.
  Future<void> submit(String email) async {
    try {
      setState(() => onSubmitted = null);
      final controller = ref.read(widget.controllerProvider);

      await controller.execute(email);
    } on Exception catch (error) {
      handlerError(error);
    } finally {
      if (mounted) setState(() => onSubmitted = submit);
    }
  }

  /// Show the error message to the user.
  void handlerError(Exception error) {
    ScaffoldMessenger.of(context).showSnackBar(
      DangerAlert.fromError(error),
    );
  }
}
