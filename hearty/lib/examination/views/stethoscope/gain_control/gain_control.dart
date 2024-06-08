import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../providers.dart';

class GainControl extends ConsumerWidget {
  const GainControl({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gainState = ref.watch(
      stethoscopeStateProvider.select(
        (value) => _GainState(gain: value.gain, opacity: value.gainOpacity),
      ),
    );
    return Positioned.fill(
      child: AnimatedOpacity(
        opacity: gainState.opacity,
        duration: Config.gainControlAnimationDuration,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => ref.read(stethoscopeStateProvider.notifier).showGain(),
          onVerticalDragStart:
              ref.read(stethoscopeStateProvider.notifier).onVerticalDragStart,
          onVerticalDragUpdate:
              ref.read(stethoscopeStateProvider.notifier).onVerticalDragUpdate,
          onVerticalDragEnd:
              ref.read(stethoscopeStateProvider.notifier).onVerticalDragEnd,
        ),
      ),
    );
  }
}

class _GainState {
  final int gain;
  final double opacity;

  _GainState({required this.gain, required this.opacity});
}
