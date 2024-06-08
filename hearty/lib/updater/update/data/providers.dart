import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../core/storage/rest/http_data_source_adapter.dart';
import 'application_metadata_repository.dart';
import 'itunes/itunes_metadata_repository.dart';

/// Defines a base URL constant for the iTunes API
const _itunesBaseUrl = 'https://itunes.apple.com/';

/// Provider for the HttpDataSource, using Dio as the HTTP client.
final itunesDataSourceProvider = Provider.autoDispose<HttpDataSource>(
  (ref) {
    final client = Dio(BaseOptions(baseUrl: _itunesBaseUrl))
      ..interceptors.add(ref.watch(logInterceptorProvider));

    return HttpDataSourceAdapter(client);
  },
);

/// Provider for the ApplicationMetadataRepository
final applicationMetadataRepositoryProvider =
    Provider.autoDispose<ApplicationMetadataRepository>(
  (ref) {
    return ItunesMetadataRepository(
      dataSource: ref.watch(itunesDataSourceProvider),
    );
  },
);
