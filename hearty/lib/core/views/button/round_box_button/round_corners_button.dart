import 'package:flutter/material.dart';

import '../../theme/index.dart';

class RoundCornersButton extends StatelessWidget {
  final Widget? child;
  final String? title;
  final VoidCallback? onTap;
  final bool enabled;
  final Gradient? gradient;
  final Color? color;
  final double width;
  final double height;
  final double? fontSize;
  final BorderRadius? borderRadius;

  const RoundCornersButton({
    super.key,
    required this.onTap,
    this.child,
    this.title,
    this.enabled = true,
    this.gradient,
    this.color,
    this.width = double.maxFinite,
    this.height = _defaultButtonHeight,
    this.borderRadius = _borderRadius,
    this.fontSize,
  }) : assert(child != null || title != null);

  @override
  Widget build(BuildContext context) {
    final grad = gradient ?? AppGradients.blue1;
    final theme = Theme.of(context);
    final boxDecoration = BoxDecoration(
      borderRadius: borderRadius,
      gradient: enabled ? grad : AppGradients.disabledButton,
      color: color,
    );

    return DecoratedBox(decoration: boxDecoration, child: _buildButton(theme));
  }

  Widget _buildButton(ThemeData theme) {
    final size = Size(width, height);
    final style = ElevatedButton.styleFrom(
      fixedSize: size,
      backgroundColor: Colors.transparent,
      elevation: _buttonElevation,
      shape: _shape,
    );

    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      style: style,
      child: title != null ? _buildText(theme) : child,
    );
  }

  Widget _buildText(ThemeData theme) {
    final textColor = theme.colorScheme.primaryContainer;
    final textStyle = theme.textTheme.headlineLarge?.copyWith(
      color: textColor,
      fontSize: fontSize,
    );
    final text = Text(title!, style: textStyle);

    return FittedBox(fit: BoxFit.scaleDown, child: text);
  }
}

const _defaultButtonHeight = 56.0;
const _buttonElevation = .0;
const _radius = 80.0;
const _borderRadius = BorderRadius.all(Radius.circular(_radius));
const _shape = RoundedRectangleBorder(borderRadius: _borderRadius);
