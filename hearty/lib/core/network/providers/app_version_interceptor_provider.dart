import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/system_info_provider.dart';
import '../interceptors/app_version_interceptor.dart';

/// Provides a [Interceptor] that add the user's app version to requests.
final appVersionInterceptorProvider = Provider<Interceptor>(
  (ref) {
    return AppVersionInterceptor(ref.read(semanticAppVersionProvider.future));
  },
);

final semanticAppVersionProvider = FutureProvider<String>((ref) {
  return ref.watch(systemInfoProvider).semanticAppVersion;
});
