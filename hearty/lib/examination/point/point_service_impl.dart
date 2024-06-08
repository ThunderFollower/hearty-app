import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'data/point_repository.dart';
import 'point.dart';
import 'point_service.dart';

/// Implements the [PointService], providing concrete implementations
/// for its operations using the [PointRepository].
class PointServiceImpl implements PointService {
  /// Constructs the service with the given [PointServiceImpl].
  PointServiceImpl(this.repository);

  /// A repository responsible for data interactions related to point.
  @protected
  final PointRepository repository;

  @protected
  final pointState = BehaviorSubject<Point>();

  void dispose() {
    pointState.close();
  }

  @override
  Stream<Point> findOne(String id, [Stream? cancellation]) => MergeStream([
        pointState.stream.where((event) => event.id == id),
        repository.findOne(id, cancellation).doOnData(pointState.sink.add),
      ]).distinct();
}
