import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchButton extends ConsumerWidget {
  final bool value;
  final VoidCallback? onChanged;
  final AlignmentGeometry alignment;

  const SwitchButton({
    super.key,
    this.onChanged,
    this.value = false,
    this.alignment = Alignment.centerRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = SwitchTheme.of(context);
    final trackColor = theme.trackColor?.resolve({MaterialState.disabled});
    final activeColor = theme.trackColor?.resolve({MaterialState.selected});

    final cupertinoSwitch = CupertinoSwitch(
      key: _cupertinoKey,
      onChanged: (_) => onChanged?.call(),
      value: value,
      trackColor: trackColor,
      activeColor: activeColor,
    );

    return Transform.scale(
      alignment: alignment,
      scale: _switchScale,
      child: cupertinoSwitch,
    );
  }
}

/// The scale of the button
const _switchScale = 0.7;

// Keys
const _cupertinoKey = Key('cupertino_key');
