import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interceptors/connection_server_error_interceptor.dart';
import 'env_url_provider.dart';

/// Provides an [Interceptor] that handles server connection errors.
final connectionInterceptorProvider = Provider<Interceptor>((ref) {
  final baseUrl = ref.watch(envUrlProvider);
  final client = Dio(BaseOptions(baseUrl: baseUrl));
  return ConnectionServerErrorInterceptor(ref, client);
});
