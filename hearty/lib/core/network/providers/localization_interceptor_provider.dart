import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../interceptors/localization_interceptor.dart';

/// Provides a [Interceptor] that add the user's language preference to requests.
final localizationInterceptorProvider = Provider<Interceptor>(
  (_) => LocalizationInterceptor(),
);
