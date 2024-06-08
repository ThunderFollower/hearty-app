import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../providers.dart';

const _baseFontSize = 110;
const _smallScreenFontSizeQuotient = 0.45;
const _overlayTextMaxOpacity = 0.6;
const _overlayTextMinOpacity = 0.3;

class GainIndicator extends ConsumerWidget {
  const GainIndicator({super.key, this.showBody = false});

  final bool showBody;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final gainState = _watchForGainChanges(ref);
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (_, constraints) {
          final fontSize = _computeFontSize(constraints);
          return _buildIndicator(gainState, fontSize, theme.colorScheme);
        },
      ),
    );
  }

  _GainState _watchForGainChanges(WidgetRef ref) {
    return ref.watch(
      stethoscopeStateProvider.select(
        (value) => _GainState(gain: value.gain, opacity: value.gainOpacity),
      ),
    );
  }

  Widget _buildIndicator(
    _GainState gainState,
    double fontSize,
    ColorScheme colorScheme,
  ) {
    final backgroundText = Text(
      'x${gainState.gain}',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..color = colorScheme.onSecondary.withOpacity(_overlayTextMaxOpacity),
      ),
    );
    final foregroundText = Text(
      'x${gainState.gain}',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w300,
        color: colorScheme.secondary.withOpacity(_overlayTextMinOpacity),
      ),
    );

    return AnimatedOpacity(
      opacity: gainState.opacity,
      duration: Config.gainControlAnimationDuration,
      child: Stack(
        alignment: Alignment.center,
        children: [
          backgroundText,
          foregroundText,
        ],
      ),
    );
  }

  double _computeFontSize(BoxConstraints constraints) =>
      constraints.maxWidth > constraints.maxHeight
          ? constraints.maxHeight * _smallScreenFontSizeQuotient
          : _baseFontSize * (constraints.maxHeight / constraints.maxWidth);
}

class _GainState {
  final int gain;
  final double opacity;

  _GainState({required this.gain, required this.opacity});
}
