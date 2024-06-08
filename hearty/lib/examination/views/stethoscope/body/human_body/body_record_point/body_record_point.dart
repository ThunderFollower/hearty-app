import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../examination.dart';
import '../../../../examination/providers.dart';
import 'detail/active_record_point.dart';
import 'detail/non_active_record_point.dart';

const _activePointSize = 35.0;
const _inactivePointSize = 14.0;
const _activePointYDelta = 0.034;
const _activePointXDelta = 0.034;

class BodyRecordPoint extends ConsumerWidget {
  final List<Record> records;
  final double offsetX;
  final double offsetY;
  final String id;
  final Spot spot;
  final String nameId;
  final double width;

  const BodyRecordPoint({
    super.key,
    required this.spot,
    required this.records,
    required this.offsetX,
    required this.offsetY,
    required this.id,
    required this.width,
    this.nameId = 'point_id',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = examinationStateProvider.select(
      (value) => value.currentSpot,
    );
    final currentSpot = ref.watch(provider);
    final isActiveSpot = currentSpot == spot;
    final size = isActiveSpot ? _activePointSize : _inactivePointSize;
    final offset = resolveOffset(currentSpot: isActiveSpot);
    final child = _buildChild(
      currentSpot: isActiveSpot,
      spotNumber: currentSpot.number,
    );
    return Positioned(
      width: size,
      height: size,
      key: Key(id),
      top: width * offset.y,
      left: width * offset.x,
      child: child,
    );
  }

  Point<double> resolveOffset({required bool currentSpot}) {
    if (currentSpot) {
      return Point(
        offsetX - _activePointXDelta,
        offsetY - _activePointYDelta,
      );
    }
    return Point(offsetX, offsetY);
  }

  Widget _buildChild({required bool currentSpot, required int spotNumber}) =>
      currentSpot
          ? ActiveRecordPoint(nameId: nameId, spotNumber: spotNumber)
          : NonActiveRecordPoint(nameId: nameId);
}
