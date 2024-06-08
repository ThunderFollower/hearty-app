import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/index.dart';
import '../network/providers/localization_interceptor_provider.dart';
import 'http_data_source.dart';
import 'rest/http_data_source_adapter.dart';

const _isHttpLoggingEnabled = bool.fromEnvironment(
  'ENABLE_HTTP_LOGGING',
);

final publicApiProvider = Provider<HttpDataSource>((ref) {
  final interceptors = [
    if (_isHttpLoggingEnabled) ref.watch(logInterceptorProvider),
    ref.watch(connectionInterceptorProvider),
    ref.watch(localizationInterceptorProvider),
    ref.watch(appVersionInterceptorProvider),
  ];
  final baseUrl = ref.watch(envUrlProvider);
  final client = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.addAll(interceptors);

  return HttpDataSourceAdapter(client);
});
