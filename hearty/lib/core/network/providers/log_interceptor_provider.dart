import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides a [Interceptor] that write logs to the console.
final logInterceptorProvider = Provider<Interceptor>(
  (_) => LogInterceptor(
    requestBody: kDebugMode,
    responseBody: kDebugMode,
  ),
);
