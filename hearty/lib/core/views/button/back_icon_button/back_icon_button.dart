import 'package:flutter/material.dart';

import '../../locator/app_locator.dart';
import '../../theme/app_icons.dart';

/// A button that displays a back icon and invokes a callback when pressed.
///
/// The [onPressed] callback should be provided to specify the action to take
/// when the button is pressed. If [onPressed] is null, the button will be
/// disabled.
class BackIconButton extends StatelessWidget {
  /// Creates a new [BackIconButton] with the given [onPressed] callback.
  ///
  /// If [onPressed] is null, the button will be disabled.
  const BackIconButton({
    super.key,
    required this.onPressed,
  });

  /// Defines the width of the back button icon.
  static const iconWidth = 20.0;

  /// Defines the width of the top bar leading item.
  ///
  /// The back button icon is centered within the leading item. Its size is
  /// 20px, and the left and right padding are 26px each, for a total width of
  /// 52px.
  static const leadingWidth = _backIconVerticalPadding * 2 + iconWidth;

  /// The callback function to invoke when the button is pressed.
  ///
  /// If this is null, the button will be disabled.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const AppLocator(id: 'back_button', child: Icon(AppIcons.back)),
      onPressed: onPressed,
    );
  }
}

/// Defines the vertical padding of the back button icon.
const _backIconVerticalPadding = 26.0;
