import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../button/index.dart';
import '../theme/indentation_constants.dart';

class InfoDialog extends StatelessWidget {
  const InfoDialog({
    required this.title,
    this.buttonTitle,
    this.onButtonTap,
  });

  final String title;
  final String? buttonTitle;
  final void Function()? onButtonTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final alertDialog = _buildAlertDialog(theme);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: alertDialog,
    );
  }

  AlertDialog _buildAlertDialog(ThemeData theme) {
    final borderRadius = BorderRadius.circular(highIndent);
    final shape = RoundedRectangleBorder(borderRadius: borderRadius);
    final button = _buildButton();
    final titleText = _buildTitleText(theme);

    return AlertDialog(
      titlePadding: _titlePadding,
      contentPadding: _contentPadding,
      insetPadding: _insetPadding,
      shape: shape,
      title: titleText,
      content: button,
    );
  }

  Center _buildTitleText(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: color);
    final text = Text(
      title,
      textAlign: TextAlign.center,
      style: textStyle,
    );

    return Center(child: text);
  }

  Widget _buildButton() => RoundCornersButton(
        title: buttonTitle ?? LocaleKeys.OK.tr(),
        onTap: onButtonTap,
      );
}

const _titlePadding = EdgeInsets.only(
  left: middleIndent,
  top: middleIndent,
  right: middleIndent,
);
const _contentPadding = EdgeInsets.all(middleIndent);
const _insetPadding = EdgeInsets.symmetric(horizontal: lowIndent);
