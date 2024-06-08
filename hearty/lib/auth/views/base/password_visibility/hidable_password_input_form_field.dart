import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'index.dart';

class HidablePasswordInputFormField extends ConsumerWidget {
  const HidablePasswordInputFormField({
    required this.fieldKey,
    required this.hintText,
    this.focusNode,
    this.autoFocus = false,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.controller,
    this.textInputAction = TextInputAction.done,
    this.autofillHints,
  });

  final String hintText;
  final Key fieldKey;
  final FocusNode? focusNode;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool autoFocus;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final passwordVisibilityControllerProvider =
        passwordVisibilityStateProvider(fieldKey);
    final passwordVisibilityState = ref.watch(
      passwordVisibilityControllerProvider,
    );
    final passwordVisibilityController = ref.watch(
      passwordVisibilityControllerProvider.notifier,
    );

    final decoration = _takeDecoration(
      passwordVisibilityState,
      passwordVisibilityController,
      theme,
    );

    return TextFormField(
      key: fieldKey,
      onSaved: onSaved,
      onChanged: (input) {
        passwordVisibilityController.handleTextChanging(input);
        onChanged?.call(input);
      },
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      autocorrect: false,
      autofocus: autoFocus,
      obscureText: !passwordVisibilityState.isPasswordVisible,
      obscuringCharacter: _obscuringCharacter,
      decoration: decoration,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
    );
  }

  /// Defines the decorations of the password input field.
  InputDecoration _takeDecoration(
    PasswordVisibilityState state,
    PasswordVisibilityController controller,
    ThemeData theme,
  ) {
    final passwordVisibilityButton = PasswordVisibilityButton(
      isPasswordVisible: state.isPasswordVisible,
      onTap: controller.changeVisibilityState,
    );
    final hintTextColor = theme.colorScheme.onTertiaryContainer;
    final hintTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: hintTextColor,
    );
    return InputDecoration(
      hintText: hintText,
      hintStyle: hintTextStyle,
      suffixIcon:
          state.shouldShowVisibilityIcon ? passwordVisibilityButton : null,
    );
  }
}

/// Defines characters that hide password symbol if it is required.
const _obscuringCharacter = '●';
