import 'package:flutter/foundation.dart';

import '../../../../core/storage/exceptions/canceled_exception.dart';
import '../../../../core/storage/http_data_source.dart';
import '../../point.dart';
import '../point_repository.dart';
import 'dto/point_response_dto/point_response_dto.dart';

class PointApiRepository implements PointRepository {
  const PointApiRepository(this.dataSource);

  /// An HTTP data source for accessing the private API.
  /// This is used to make API requests.
  @protected
  final HttpDataSource dataSource;

  @override
  Stream<Point> findOne(String id, [Stream? cancellation]) async* {
    try {
      yield await dataSource.get(
        _pathToEntity(id),
        cancellationStream: cancellation,
        deserializer: PointResponseDto.fromJson,
      );
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }
}

const _path = '/points';
String _pathToEntity(String id) => '$_path/$id';
