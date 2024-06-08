import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import 'api/record_api_repository.dart';
import 'db/record_db_repository.dart';
import 'record_repository.dart';

final recordRepositoryProvider = Provider.autoDispose<RecordRepository>(
  (ref) {
    final fallbackRepository = RecordApiRepository(
      ref.watch(privateApiProvider),
      HttpCancelToken(),
    );

    return RecordDbRepository(
      fallbackRepository,
      ref.watch(userDatabaseFutureProvider.future),
      Logger(),
    );
  },
);
