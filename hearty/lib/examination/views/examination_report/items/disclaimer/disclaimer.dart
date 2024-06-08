import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({required this.onOpenGuide});

  final void Function() onOpenGuide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final row = Row(
      children: [
        _buildVerticalDivider(theme),
        const SizedBox(width: lowIndent),
        _buildText(theme),
      ],
    );
    return IntrinsicHeight(child: row);
  }

  Widget _buildText(ThemeData theme) {
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText(theme),
        const SizedBox(height: _tinyIndent),
        _buildBodyText(theme),
        const SizedBox(height: lowestIndent),
        _buildFooterText(theme),
      ],
    );
    return Flexible(child: column);
  }

  Widget _buildFooterText(ThemeData theme) {
    final color = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.bodyLarge?.copyWith(color: color);
    return GestureDetector(
      onTap: onOpenGuide,
      child: Row(
        children: [
          Text(
            LocaleKeys.ExaminationReport_disclaimer_footer.tr(),
            style: textStyle,
          ),
          _buildIcon(color),
        ],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    final icon = Icon(AppIcons.collapse, size: _iconSize, color: color);
    return RotatedBox(
      quarterTurns: _iconQuarterTurns,
      child: SizedBox(child: icon),
    );
  }

  Widget _buildBodyText(ThemeData theme) {
    final color = theme.colorScheme.onPrimaryContainer;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(color: color);
    return Text(
      LocaleKeys.ExaminationReport_disclaimer_body.tr(),
      style: textStyle,
    );
  }

  Widget _buildTitleText(ThemeData theme) {
    final textStyle = theme.textTheme.bodyLarge;
    return Text(
      LocaleKeys.ExaminationReport_disclaimer_title.tr(),
      style: textStyle,
    );
  }

  Widget _buildVerticalDivider(ThemeData theme) {
    final color = theme.colorScheme.secondary;
    final decoration = BoxDecoration(
      borderRadius: _dividerBorderRadius,
      color: color,
    );
    return Container(
      width: _dividerWidth,
      height: double.infinity,
      decoration: decoration,
    );
  }
}

const _dividerWidth = 3.0;
const _tinyIndent = 4.0;
final _dividerBorderRadius = BorderRadius.circular(lowestIndent);
const _iconSize = 14.0;
const _iconQuarterTurns = 3;
