import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views.dart';
import 'constants.dart';
import 'email_form_field.dart';

/// Defines a form with an e-mail form field.
class EmailForm extends ConsumerStatefulWidget {
  final String submitText;
  final ValueChanged<String>? onSubmitted;
  final String? initialEmail;

  /// Creates a form with an e-mail form field.
  const EmailForm({
    super.key,
    required this.submitText,
    this.onSubmitted,
    this.initialEmail,
  });

  @override
  ConsumerState createState() => _EmailFormState();
}

/// Defines a form with an e-mail form field.
class _EmailFormState extends ConsumerState<EmailForm> {
  /// Control the editing of the email field.
  TextEditingController? controller;

  /// The key that is controlling the form validation.
  GlobalKey<FormState>? formKey;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.initialEmail);
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }

  void submit() {
    if (controller != null && formKey?.currentState?.validate() == true) {
      widget.onSubmitted?.call(controller!.value.text);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: formRoot(),
      );

  Widget formRoot() => Column(
        children: [
          EmailFormField(
            key: formEmailKey,
            controller: controller,
            onSubmitted: (_) => submit(),
          ),
          const SizedBox(height: highIndent),
          RoundCornersButton(
            key: formSubmitKey,
            title: widget.submitText,
            onTap: submit,
          ),
        ],
      );
}
