import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../record/playback_controls/filters_extension.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';

class OscillogramPaint extends ConsumerWidget {
  const OscillogramPaint({super.key});

  static const double lineWidth = 2.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scale = ref.watch(stethoscopeStateProvider.select(_selectScale));
    final paint = Paint()
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = lineWidth
      ..color = Theme.of(context).colorScheme.secondary
      ..style = PaintingStyle.stroke;

    return wrap(
      _SignalPaint(paint: paint, scale: scale),
    );
  }

  Widget wrap(Widget widget) => RepaintBoundary(child: widget);

  static double _selectScale(StethoscopeState value) =>
      1.0 / value.activeFilter.oscilloHeightDivider;
}

class _SignalPaint extends ConsumerWidget {
  const _SignalPaint({
    required this.paint,
    required this.scale,
  });

  final Paint paint;
  final double scale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signal = ref.watch(stethoscopeStateProvider.select(_selectSignal));
    final painter = _TracePainter(
      dataSet: signal,
      tracePaint: paint,
      scale: scale,
    );
    return CustomPaint(size: Size.infinite, painter: painter);
  }

  static List<double> _selectSignal(StethoscopeState value) => value.signal;
}

class _TracePainter extends CustomPainter {
  _TracePainter({
    required this.dataSet,
    required this.scale,
    required this.tracePaint,
  });

  final List<double> dataSet;
  final Paint tracePaint;
  final double scale;

  /// The length of an oscillogram sample.
  static const sampleLength = int.fromEnvironment(
    'SAMPLE_LENGTH',
    defaultValue: 1000,
  );

  double _computeY({required double value, required double height}) {
    final val = value * height * scale + height * 0.5;
    if (val > height) {
      return height;
    }
    if (val < 0) {
      return 0;
    }
    return val;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (dataSet.isEmpty) {
      return;
    }

    final int length = dataSet.length;
    final double step = size.width / sampleLength;
    final Path trace = Path();
    trace.moveTo(
      size.width,
      _computeY(value: dataSet.last, height: size.height),
    );

    for (int i = length - 1; i >= 0; i--) {
      trace.lineTo(
        step * (sampleLength - length + i + 1),
        _computeY(value: dataSet[i], height: size.height),
      );
    }
    canvas.drawPath(trace, tracePaint);
  }

  @override
  bool shouldRepaint(_) => true;
}
