import 'package:dio/dio.dart';

/// Adds the 'Accept-Version' header to the HTTP request to specify the user's
/// app version
class AppVersionInterceptor extends Interceptor {
  const AppVersionInterceptor(this._semanticAppVersionFuture);

  final Future<String> _semanticAppVersionFuture;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers[_acceptVersion] = await _semanticAppVersionFuture;
    return handler.next(options);
  }
}

const _acceptVersion = 'Accept-Version';
