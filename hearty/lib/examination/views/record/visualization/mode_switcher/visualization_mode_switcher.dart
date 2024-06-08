import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../../../../../generated/locale_keys.g.dart';

class VisualizationModeSwitcher extends StatelessWidget {
  // it's made non-const to be rebuilt with parent change
  // ignore: prefer_const_constructors_in_immutables
  VisualizationModeSwitcher({super.key, this.onTap, this.isSpectrogramMode});

  final VoidCallback? onTap;

  /// Indicates if the spectrogram mode is active.
  final bool? isSpectrogramMode;

  @override
  Widget build(BuildContext context) => Positioned(
        key: _switcherKey,
        top: lowestIndent,
        right: lowIndent,
        child: _ModeButton(onTap: onTap, isSpectrogramMode: isSpectrogramMode),
      );
}

class _ModeButton extends StatelessWidget {
  const _ModeButton({
    required this.onTap,
    required this.isSpectrogramMode,
  });

  final VoidCallback? onTap;
  final bool? isSpectrogramMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final buttonColor = theme.colorScheme.secondary.withOpacity(_buttonOpacity);
    final boxDecoration = BoxDecoration(
      color: buttonColor,
      borderRadius: BorderRadius.circular(belowHightIndent),
    );

    final row = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildIcon(),
        const SizedBox(width: halfOfLowestIndent),
        _buildText(theme),
      ],
    );

    final container = Container(
      height: statusBarIndent,
      alignment: Alignment.center,
      padding: _padding,
      decoration: boxDecoration,
      child: row,
    );
    return InkWell(onTap: onTap, child: container);
  }

  Widget _buildText(ThemeData theme) {
    final textStyle = theme.textTheme.bodyLarge;
    return Text(
      LocaleKeys.Oscillo,
      style: textStyle,
    ).tr();
  }

  Widget _buildIcon() => Icon(AppIcons.oscillo);
}

const _padding = EdgeInsets.symmetric(horizontal: lowIndent);
const _buttonOpacity = 0.3;

// Keys
const _switcherKey = Key('switch_graphs_button');
