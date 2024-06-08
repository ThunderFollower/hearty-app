import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/views.dart';

class DrawerProperty extends StatelessWidget {
  final String title;
  final VoidCallback handler;
  final bool isTurnedOn;
  final VoidCallback? infoTap;

  const DrawerProperty({
    super.key,
    required this.title,
    required this.handler,
    required this.isTurnedOn,
    this.infoTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = _buildContent(theme);

    return ListTile(
      contentPadding: _contentPadding,
      onTap: handler,
      title: content,
    );
  }

  Widget _buildContent(ThemeData theme) {
    final textStyle = theme.textTheme.bodyLarge;
    final text = Text(title, style: textStyle);
    const sizedBox = SizedBox(width: veryHighIndent);
    final textProperty = Stack(
      alignment: Alignment.centerRight,
      children: [
        Row(children: [text, sizedBox]),
        if (infoTap != null) _buildQuestionButton(theme),
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [textProperty, _buildSwitchButton()],
    );
  }

  Widget _buildQuestionButton(ThemeData theme) {
    final questionButtonColor = theme.colorScheme.onBackground;
    final colorFilter = ColorFilter.mode(questionButtonColor, BlendMode.srcIn);
    final svgPicture = SvgPicture.asset(
      _iconPath,
      height: belowMediumIndent,
      width: belowMediumIndent,
      colorFilter: colorFilter,
    );
    final appLocator = AppLocator(id: '${title}_info', child: svgPicture);

    return IconButton(onPressed: infoTap, icon: appLocator);
  }

  Widget _buildSwitchButton() => SwitchButton(
        onChanged: handler,
        value: isTurnedOn,
        alignment: Alignment.center,
      );
}

const _contentPadding = EdgeInsets.symmetric(horizontal: aboveLowestIndent);
const _iconPath = 'assets/images/question.svg';
