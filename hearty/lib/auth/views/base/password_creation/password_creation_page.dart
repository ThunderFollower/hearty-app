import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../core/views.dart';
import '../../../../core/views/title_bar/back_title_bar_item.dart';
import '../../../../generated/locale_keys.g.dart';
import '../index.dart';
import '../invisible_email_field/invisible_email_field.dart';
import 'constants.dart';
import 'password_validation/constants.dart';

const _pagePadding = EdgeInsets.symmetric(
  horizontal: middleIndent,
  vertical: belowMediumIndent,
);

const _formConfirmPasswordKey = Key('confirm');

/// This page allows the user to set a password for the account.
///
/// It is used in the following flows:
/// - sign up
/// - account recovery
///
/// It is an abstract class; [controllerProvider] must be implemented.
class PasswordCreationPage extends ConsumerStatefulWidget {
  /// Creates a page that allows the user to set a password for the account.
  PasswordCreationPage({
    super.key,
    required this.notifierProvider,
    required this.onSubmit,
    required this.email,
  });

  /// The key of the form to validate the form status.
  final formKey = GlobalKey<FormState>();

  /// A provider of a controller to validate the password.
  final Refreshable<PasswordValidationStateNotifier> notifierProvider;

  /// A callback function that is called when the user submits their password.
  /// The function takes a single argument which is the user's entered password.
  final Future<void> Function(String) onSubmit;

  final String email;

  @override
  ConsumerState<PasswordCreationPage> createState() =>
      _CreatePasswordPageState();
}

class _CreatePasswordPageState extends ConsumerState<PasswordCreationPage> {
  /// Controls the first password field.
  late TextEditingController firstPasswordController;

  /// Controls the second password field.
  late TextEditingController secondPasswordController;

  /// Manages the focus of the second password fields.
  late FocusNode secondPasswordFocusNode;

  /// True if the password is being created.
  bool isSubmitting = false;

  @override
  void dispose() {
    firstPasswordController.dispose();
    secondPasswordController.dispose();
    secondPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    firstPasswordController = TextEditingController();
    secondPasswordController = TextEditingController();
    secondPasswordFocusNode = FocusNode();
    isSubmitting = false;
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(widget.notifierProvider);
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: rootView(),
    );
  }

  /// Returns the root view of the page.
  Widget rootView() => Semantics(
        label: _pageLabel,
        child: AppScaffold(
          backgroundColor: Colors.pink.shade100,
          appBar: _buildAppBar(),
          body: pageBody(),
        ),
      );

  AppBar _buildAppBar() {
    final text = Text(
      LocaleKeys.Create_password.tr(),
      semanticsLabel: _titleLabel,
      key: _titleKey,
    );
    final leading = Semantics(
      label: _leadingButtonLabel,
      button: true,
      child: const BackTitleBarItem(),
    );
    return AppBar(title: text, leading: leading, leadingWidth: _leadingWidth);
  }

  /// Returns the body of the root view.
  SingleChildScrollView pageBody() => SingleChildScrollView(
        padding: _pagePadding,
        child: formRoot(),
      );

  /// Returns the root view of the form.
  Center formRoot() => Center(child: form());

  /// Returns the main form.
  Form form() => Form(
        key: widget.formKey,
        child: AutofillGroup(child: formBody()),
      );

  /// Returns the body of the main form.
  Column formBody() {
    final children = [
      _buildPasswordValidation(),
      // To enable autofill feature
      _buildInvisibleEmailField(),

      firstPasswordField(),
      const SizedBox(height: highIndent),
      secondPasswordInputField(),
      const SizedBox(height: highIndent),
      submitButton(),
    ];
    return Column(children: children);
  }

  Widget _buildInvisibleEmailField() =>
      InvisibleEmailField(email: widget.email);

  Widget _buildPasswordValidation() => Semantics(
        label: _passwordValidationLabel,
        child: const PasswordValidationContainer(),
      );

  /// Returns the first password field.
  Widget firstPasswordField() {
    final validationController = ref.read(widget.notifierProvider);

    final inputField = HidablePasswordInputFormField(
      fieldKey: formPasswordKey,
      hintText: LocaleKeys.Enter_password.tr(),
      onChanged: validationController.validate,
      controller: firstPasswordController,
      validator: validate,
      autoFocus: true,
      onFieldSubmitted: (_) => secondPasswordFocusNode.requestFocus(),
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
    );

    return Semantics(
      label: _firstPasswordFieldLabel,
      hint: LocaleKeys.Enter_password.tr(),
      focusable: true,
      obscured: true,
      textField: true,
      child: inputField,
    );
  }

  /// Returns the second password field to match passwords.
  Widget secondPasswordInputField() {
    final inputField = HidablePasswordInputFormField(
      fieldKey: _formConfirmPasswordKey,
      hintText: LocaleKeys.Confirm_password.tr(),
      controller: secondPasswordController,
      validator: validate,
      focusNode: secondPasswordFocusNode,
      onFieldSubmitted: (_) => submit(),
      textInputAction: TextInputAction.go,
      autofillHints: const [AutofillHints.newPassword],
    );

    return Semantics(
      label: _secondPasswordFieldLabel,
      hint: LocaleKeys.Confirm_password.tr(),
      focusable: true,
      obscured: true,
      textField: true,
      child: inputField,
    );
  }

  /// Returns the action button to go ahead with the password creation.
  Widget submitButton() {
    final button = RoundCornersButton(
      title: LocaleKeys.Create.tr(),
      onTap: submit,
      key: formSubmitKey,
    );
    return Semantics(
      label: _submitButtonLabel,
      hint: LocaleKeys.Create.tr(),
      button: true,
      child: button,
    );
  }

  /// This function is called when the user taps the submit button.
  ///
  /// It handles all errors that may occur during the password creation.
  ///
  /// Returns a completed Future.
  Future<void> submit() async {
    // If the form is not valid, do not submit.
    if (isSubmitting || !widget.formKey.currentState!.validate()) return;

    // Prevent the user from submitting the form twice.
    setState(() => isSubmitting = true);

    final password = firstPasswordController.value.text;

    try {
      await widget.onSubmit(password);
    } finally {
      if (mounted) setState(() => isSubmitting = false);
    }
  }

  /// Match the first and second password fields.
  String? validate(String? password) {
    if (firstPasswordController.value.text !=
        secondPasswordController.value.text) {
      return LocaleKeys.Passwords_do_not_match.tr();
    }

    if (password!.isEmpty) return LocaleKeys.Password_is_required.tr();
    if (!isPasswordMetRequirements(password)) {
      return LocaleKeys.Password_does_not_meet_the_requirements.tr();
    }

    return null;
  }

  bool isPasswordMetRequirements(String password) {
    return hasNumberPattern.hasMatch(password) &&
        hasUppercasePattern.hasMatch(password) &&
        hasLowercasePattern.hasMatch(password) &&
        hasSpecialCharPattern.hasMatch(password) &&
        password.length >= Config.passwordMinLength;
  }
}

/// Defines the size of the menu icon.
const _backIconSize = 20.0;
const _backIconVerticalPadding = 26.0;

/// Defines the width of the top bar leading item.
///
/// Menu icon is centered. It's size is 20px. Left and right padding are 26px.
const _leadingWidth = _backIconVerticalPadding * 2 + _backIconSize;

/// Labels for testing
const _titleLabel = 'title_text';
const _titleKey = Key('title_text_key');
const _pageLabel = 'password_creation_page';
const _passwordValidationLabel = 'password_validation';
const _firstPasswordFieldLabel = 'first_password_field_label';
const _secondPasswordFieldLabel = 'second_password_field_label';
const _submitButtonLabel = 'submit_button_label';
const _leadingButtonLabel = 'leading_button';
