import 'package:flutter/material.dart';

class InvisibleEmailField extends StatelessWidget {
  const InvisibleEmailField({this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final textFormField = TextFormField(
      initialValue: email,
      enabled: false,
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.username],
    );

    return Semantics(
      label: _invisibleEmailFieldLabel,
      hidden: true,
      child: SizedBox.shrink(child: textFormField),
    );
  }
}

/// Labels for testing
const _invisibleEmailFieldLabel = 'invisible_email_field';
