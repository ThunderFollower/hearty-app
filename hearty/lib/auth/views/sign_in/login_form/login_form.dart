import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import 'constants.dart';
import 'login_name_field.dart';
import 'login_password_field.dart';

/// A form to login to the application.
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key, this.onSubmit});

  /// The callback to be called when the user submits the form.
  final void Function(String, String)? onSubmit;

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String _email = '';
  String _password = '';

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Input fields, like the email and password, change their height
    // if there is a decorated error text below the field.
    // It affects the page layout. In other words,
    // it either pushes everything down or squeezes the input field
    // to make some room for the decorated text.
    // Thus, the email field, password field, and the submit button can
    // get stuck to the top, or better to say, to the logo on the screen top.
    // This way, they keep their positions relative to the screen's top
    // rather than each other.

    final inputHeight = calculateInputHeight(context);
    final submitHeight = calculateButtonHeight(context);

    final inputOffset = inputHeight + logInFormMargin;
    // There are two input fields before the submit button, so we need to
    // double the offset.
    final submitOffset = inputOffset * 2.0;

    final passwordPadding = EdgeInsets.only(top: inputOffset);
    final submitPadding = EdgeInsets.only(top: submitOffset);

    final password = Container(
      padding: passwordPadding,
      child: passwordField(),
    );
    final submitButton = RoundCornersButton(
      key: _loginSubmitButtonKey,
      title: LocaleKeys.Login.tr(),
      onTap: widget.onSubmit == null ? null : _submit,
      enabled: widget.onSubmit != null,
      height: submitHeight,
    );

    final button = Container(padding: submitPadding, child: submitButton);
    final stack = Stack(children: [emailField(), password, button]);

    final autoFillGroup = AutofillGroup(child: stack);

    return Form(key: _formKey, child: autoFillGroup);
  }

  Widget emailField() => LoginNameField(
        onSaved: (email) => _email = email ?? '',
        focusNode: _emailFocusNode,
      );

  Widget passwordField() => LoginPasswordField(
        onSaved: (password) => _password = password ?? '',
        onFieldSubmitted: widget.onSubmit == null ? null : (_) => _submit(),
        focusNode: _passwordFocusNode,
      );

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit?.call(_email, _password);
    }
  }
}

const _loginSubmitButtonKey = Key('login_submit_btn');
