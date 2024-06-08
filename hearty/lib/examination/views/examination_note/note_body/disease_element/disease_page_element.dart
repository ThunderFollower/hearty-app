import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/views.dart';

typedef Validator = String? Function(String?)?;

class DiseasePageElement extends StatelessWidget {
  const DiseasePageElement({
    super.key,
    this.initialValue,
    this.updateElement,
    required this.title,
    this.titleTap,
    this.hintText = '',
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.controller,
    this.textInputType,
    this.validator,
    this.enabled,
    this.inputFormatters,
  });

  final String? initialValue;
  final Function(String)? updateElement;
  final VoidCallback? titleTap;
  final String title;
  final String hintText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Validator validator;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fillColor = theme.colorScheme.tertiary;

    final row = Row(
      children: [
        Expanded(
          child: Padding(
            padding: _smallPadding,
            child: _Title(title: title, titleTap: titleTap),
          ),
        ),
      ],
    );
    const sizedBox = SizedBox(height: belowLowIndent);
    final textInputField = TextInputField(
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      initialValue: initialValue,
      fillColor: fillColor,
      onChanged: updateElement,
      textInputType: textInputType ??
          (maxLines > 1 ? TextInputType.multiline : TextInputType.text),
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      validator: validator,
      inputFormatters: inputFormatters,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [row, sizedBox, textInputField],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({required this.title, this.titleTap});

  final String title;
  final VoidCallback? titleTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge;

    final svgPicture = SvgPicture.asset(_questionIconPath, height: lowIndent);
    final iconButton = GestureDetector(onTap: titleTap, child: svgPicture);

    final textSpan = TextSpan(
      text: title,
      children: [
        if (titleTap != null)
          WidgetSpan(
            child: Padding(padding: _tinyPadding, child: iconButton),
            alignment: PlaceholderAlignment.middle,
          ),
      ],
    );
    return Text.rich(textSpan, style: textStyle);
  }
}

const _questionIconPath = 'assets/images/question.svg';
const _smallPadding = EdgeInsets.only(left: lowestIndent);
const _tinyPadding = EdgeInsets.only(left: halfOfLowestIndent);
