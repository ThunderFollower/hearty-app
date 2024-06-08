import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';

final _labelTextStyle = textStyleOfNeptuneColor14;
const _actionTextStyle = texStyleOfBrandColorMedium14;

/// Defines a view of a countdown timer with a [text] label
/// and [actionText] button.
///
/// A [value] is displayed on the action button.
///
/// If the [value] is > 0, it will not react to touch.
///
/// If the [onPressed] and [onLongPress] callbacks are null, then this
/// widget will be disabled, it will not react to touch.
class CountdownWidget extends ConsumerWidget {
  /// The countdown value to display.
  final Duration value;

  /// The callback is called on the action button press.
  final VoidCallback? onPressed;

  /// The callback is called on the action button long press.
  final VoidCallback? onLongPress;

  /// Text of the countdown timer.
  final String text;

  /// The description of action on the button.
  final String actionText;

  /// The text shows before the countdown timer.
  final String counterText;

  /// Create a view of a countdown timer.
  const CountdownWidget(
    this.value, {
    super.key,
    required this.text,
    this.onPressed,
    this.onLongPress,
    required this.actionText,
    required this.counterText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [_leadingLabel(), _action()],
    );
  }

  /// Return whether or not this countdown timer will react react to touch.
  bool get isActive => value.inSeconds <= 0;

  /// Leading label of the countdown timer.
  Text _leadingLabel() => Text(text, style: _labelTextStyle);

  /// Action button of the countdown timer.
  Widget _action() => isActive ? _button() : _counter();

  /// Action button of the countdown timer.
  Widget _button() => TextButton(
        onPressed: onPressed,
        onLongPress: onLongPress,
        child: Text(actionText, style: _actionTextStyle),
      );

  /// Counter of the countdown timer.
  Widget _counter() {
    final textValue = value.inSeconds.toString();
    final seconds = LocaleKeys.in_number_sec.tr(args: [textValue]);
    return Text(' $counterText $seconds', style: _actionTextStyle);
  }
}
