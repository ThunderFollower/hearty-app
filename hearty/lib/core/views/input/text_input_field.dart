import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/index.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({
    required this.initialValue,
    this.hintText = '',
    this.onChanged,
    this.onSaved,
    this.onSubmit,
    this.onEditingComplete,
    this.validator,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.minLines,
    this.width,
    this.height,
    this.focusNode,
    this.obscure = false,
    this.filled = true,
    this.fillColor,
    this.textInputAction,
    this.padding = EdgeInsets.zero,
    this.maxLength,
    this.controller,
    this.autoFocus = false,
    this.fieldKey,
    this.autocorrect = true,
    this.contentPadding,
    this.enabled,
    this.inputFormatters,
  });

  final String hintText;
  final String? initialValue;
  final FocusNode? focusNode;
  final Function(String?)? onSaved;
  final Function(String)? onSubmit;
  final Function(String)? onChanged;
  final VoidCallback? onEditingComplete;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final TextInputAction? textInputAction;
  final int maxLines;
  final int? minLines;
  final double? width;
  final double? height;
  final bool obscure;
  final bool filled;
  final Color? fillColor;
  final EdgeInsets padding;
  final EdgeInsets? contentPadding;
  final int? maxLength;
  final TextEditingController? controller;
  final bool autoFocus;
  final Key? fieldKey;
  final bool autocorrect;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hintTextColor = theme.colorScheme.onTertiaryContainer;
    final hintTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: hintTextColor,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: padding,
          alignment: Alignment.centerLeft,
          height: height,
          width: width,
          child: TextFormField(
            enabled: enabled,
            key: fieldKey,
            autofocus: autoFocus,
            controller: controller,
            maxLength: maxLength,
            onFieldSubmitted: onSubmit,
            onChanged: onChanged,
            onSaved: onSaved,
            onEditingComplete: onEditingComplete,
            validator: validator,
            obscureText: obscure,
            focusNode: focusNode,
            maxLines: maxLines,
            minLines: minLines,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            keyboardType: textInputType,
            initialValue: initialValue,
            textInputAction: _getTextInputAction(),
            decoration: InputDecoration(
              counterText: '',
              filled: filled,
              fillColor: fillColor,
              hintText: hintText,
              hintStyle: hintTextStyle,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(
                    horizontal: belowMediumIndent,
                    vertical: maxLines > 1 ? belowMediumIndent : 0,
                  ),
            ),
            autocorrect: autocorrect,
            inputFormatters: inputFormatters,
          ),
        ),
      ],
    );
  }

  TextInputAction _getTextInputAction() {
    if (textInputAction != null) {
      return textInputAction!;
    }

    return textInputType != TextInputType.multiline
        ? TextInputAction.next
        : TextInputAction.newline;
  }
}
