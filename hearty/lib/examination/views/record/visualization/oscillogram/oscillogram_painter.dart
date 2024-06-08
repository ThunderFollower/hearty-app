import 'package:flutter/material.dart';

import '../../../../../../../../config.dart';
import '../../../../../../../../core/views.dart';
import '../../../../examination.dart';
import '../segment/segment.dart';

class OscillogramPainter extends CustomPainter {
  OscillogramPainter({
    required this.width,
    required this.dataSet,
    double lineWidth = 1,
    Color lineColor = Colors.white,
    required this.maxValue,
    this.segments,
  }) : _tracePaint = Paint()
          ..strokeJoin = StrokeJoin.round
          ..strokeWidth = lineWidth
          ..color = lineColor
          ..style = PaintingStyle.stroke;

  final Iterable<double> dataSet;
  final Paint _tracePaint;
  final double width;
  final double maxValue;
  final Iterable<SegmentState>? segments;

  final _colors = {
    SegmentTypes.s1: Colors.pink,
    SegmentTypes.s2: AppColors.ochre,
    SegmentTypes.s3: AppColors.red.shade500,
    SegmentTypes.s4: AppColors.red.shade500,
    SegmentTypes.unsegmentable: AppColors.grey.shade300,
  };
  final _defaultColor = AppColors.grey.shade300;

  /// The target sample rate is 4 KHz.
  static const _targetSampleRate = int.fromEnvironment(
    'TARGET_SAMPLE_RATE',
    defaultValue: 4000,
  );

  double _computeY({required double value, required double height}) =>
      value / maxValue * height / 2.5 + height / 2;

  int _timeToIndex(double time) {
    final index = (time * _targetSampleRate).toInt();
    final maxIndex = Config.signalDuration.inSeconds * _targetSampleRate - 1;
    return index > maxIndex ? maxIndex : index;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final int length = dataSet.length;
    final double step = width / length;

    final previousEnd = _paintSegments(canvas, size, step);
    final lastPoint =
        _timeToIndex(Config.signalDuration.inSeconds.toDouble()) - 1;

    final lastIndex =
        dataSet.length > lastPoint ? lastPoint : dataSet.length - 1;
    if (previousEnd < lastPoint) {
      _draw(
        canvas,
        size,
        step: step,
        start: previousEnd,
        end: lastIndex,
      );
    }
  }

  int _paintSegments(Canvas canvas, Size size, double step) {
    int result = 0;
    for (final segment in segments?.toList() ?? <SegmentState>[]) {
      final start = _timeToIndex(segment.start);
      final end = _timeToIndex(segment.end);
      final unsegmentedLength = start - result;
      if (unsegmentedLength > 0) {
        _draw(
          canvas,
          size,
          step: step,
          start: result,
          end: start,
        );
      }

      _draw(
        canvas,
        size,
        type: segment.type,
        step: step,
        start: start,
        end: end,
      );

      result = end;
    }
    return result;
  }

  void _draw(
    Canvas canvas,
    Size size, {
    SegmentTypes? type,
    required double step,
    required int start,
    required int end,
  }) {
    final path = Path();
    path.moveTo(
      step * start,
      _computeY(value: dataSet.elementAt(start), height: size.height),
    );

    for (int p = start; p <= end; p++) {
      path.lineTo(
        step * p,
        _computeY(value: dataSet.elementAt(p), height: size.height),
      );
    }

    _tracePaint.color = _colors[type] ?? _defaultColor;
    canvas.drawPath(path, _tracePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
