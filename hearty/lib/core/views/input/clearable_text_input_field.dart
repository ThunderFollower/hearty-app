import 'package:flutter/material.dart';

import '../locator/app_locator.dart';
import '../theme/index.dart';
import 'text_input_field.dart';

const _defaultPadding = EdgeInsets.only(
  left: belowMediumIndent,
  right: veryHighIndent,
);

class ClearableTextInputField extends StatefulWidget {
  const ClearableTextInputField({
    this.initialValue,
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
    this.filled = true,
    this.fillColor,
    this.textInputAction,
    this.padding = EdgeInsets.zero,
    this.maxLength,
    this.obscure = false,
    this.controller,
    this.autoFocus = false,
    this.fieldKey,
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
  final bool filled;
  final Color? fillColor;
  final EdgeInsets padding;
  final int? maxLength;
  final bool obscure;
  final TextEditingController? controller;
  final bool autoFocus;
  final Key? fieldKey;

  @override
  State<ClearableTextInputField> createState() =>
      _ClearableTextInputFieldState();
}

class _ClearableTextInputFieldState extends State<ClearableTextInputField> {
  bool _showClearFieldButton = false;
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final closeIconColor = theme.colorScheme.onTertiaryContainer;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: widget.padding,
              alignment: Alignment.centerLeft,
              height: widget.height,
              width: widget.width,
              child: TextInputField(
                fieldKey: widget.fieldKey,
                obscure: widget.obscure,
                focusNode: widget.focusNode,
                width: widget.width,
                height: widget.height,
                fillColor: widget.fillColor,
                filled: widget.filled,
                initialValue: widget.initialValue,
                hintText: widget.hintText,
                controller: _textEditingController,
                validator: widget.validator,
                onChanged: (value) {
                  widget.onChanged?.call(value);
                  setState(() => _showClearFieldButton = value.isNotEmpty);
                },
                autoFocus: widget.autoFocus,
                textInputAction: widget.textInputAction,
                onSaved: widget.onSaved,
                onSubmit: widget.onSubmit,
                onEditingComplete: widget.onEditingComplete,
                contentPadding: _defaultPadding,
              ),
            ),
          ],
        ),
        if (_showClearFieldButton)
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                _textEditingController.clear();
                widget.onChanged?.call('');
                setState(() => _showClearFieldButton = false);
              },
              splashRadius: 10,
              icon: AppLocator(
                id: 'clear_text_button',
                child: Icon(
                  AppIcons.close,
                  color: closeIconColor,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
