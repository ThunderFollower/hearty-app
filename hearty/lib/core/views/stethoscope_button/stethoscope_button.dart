import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import '../../views.dart';

/// A button that opens a Stethoscope.
class StethoscopeButton extends StatelessWidget {
  /// Creates a [StethoscopeButton] with an optional [onTap] callback.
  const StethoscopeButton({super.key, this.onTap});

  /// A callback function that will be called when the button is tapped.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        highlightColor: Colors.transparent,
        child: SizedBox(
          width: _width,
          height: _height,
          child: _buildLayout(context),
        ),
      );

  /// Builds the layout of the button.
  Widget _buildLayout(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = _resolveStyle(theme);
    final iconColor = _resolveIconColor(theme.colorScheme);
    return Column(
      children: [
        _buildIcon(iconColor),
        const Spacer(),
        _buildLabel(textStyle),
      ],
    );
  }

  /// Resolves the appropriate color for the button based on the given [scheme].
  Color _resolveIconColor(ColorScheme scheme) =>
      onTap == null ? Colors.pink : Colors.pink;

  Color _resolveTextColor(ColorScheme scheme) =>
      onTap == null ? scheme.secondaryContainer : scheme.onSurface;

  /// Resolves the appropriate text style for the button based on the current theme.
  TextStyle? _resolveStyle(ThemeData theme) {
    final color = _resolveTextColor(theme.colorScheme);

    return theme.textTheme.labelSmall?.copyWith(color: color);
  }
}

/// Builds the stethoscope icon with the given [color].
Widget _buildIcon(Color? color) => Icon(AppIcons.live, color: color);

/// Builds the label text for the stethoscope button with the given [style].
Widget _buildLabel(TextStyle? style) => FittedBox(
      child: Text(LocaleKeys.Stethoscope.tr(), style: style),
    );

/// The width of the stethoscope button.
const _width = 88.0;

/// The height of the stethoscope button.
const _height = 46.0;
