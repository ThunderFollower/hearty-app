import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../../../core/views.dart';

class CountdownArch extends StatelessWidget {
  const CountdownArch({
    super.key,
    required this.totalTime,
    required this.timeLeft,
    this.size = 64,
    this.strokeWidth = 3,
  });

  final double size;
  final double strokeWidth;
  final int totalTime;
  final int timeLeft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.background;
    final activeColor = theme.colorScheme.error;

    return Stack(
      children: [
        CustomPaint(
          size: Size.square(size),
          painter: _ProgressArch(
            strokeWidth: strokeWidth,
            color: backgroundColor,
          ),
        ),
        CustomPaint(
          size: Size.square(size),
          painter: _ProgressArch(
            arc: timeLeft / totalTime,
            gradient: LinearGradient(colors: AppGradients.red.colors),
            strokeWidth: strokeWidth,
            color: activeColor,
          ),
        ),
      ],
    );
  }
}

class _ProgressArch extends CustomPainter {
  _ProgressArch({
    this.arc,
    this.strokeWidth = 3,
    required this.color,
    this.gradient,
  });

  final Color color;
  final double? arc;
  final Gradient? gradient;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final shader = gradient?.createShader(rect);
    const startAngle = -math.pi / 2;
    final sweepAngle = arc != null ? math.pi * 2 * arc! : math.pi * 2;
    const useCenter = false;
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = shader;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
