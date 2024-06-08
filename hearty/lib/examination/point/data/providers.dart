import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import 'api/point_api_repository.dart';
import 'db/point_db_repository.dart';
import 'point_repository.dart';

/// A provider responsible for creating an instance of [PointRepository].
final pointRepositoryProvider = Provider.autoDispose<PointRepository>((ref) {
  final apiRepository = PointApiRepository(ref.watch(privateApiProvider));

  return PointDbRepository(
    apiRepository,
    ref.watch(userDatabaseFutureProvider.future),
    Logger(),
  );
});
