import 'package:dio/dio.dart';

import '../../logger/index.dart';

class LoggerInterceptor extends Interceptor {
  LoggerInterceptor({required this.logger});

  final AppLogger logger;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    logger.writeOnRequest(options);
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    logger.writeOnError(err);
    return handler.next(err);
  }
}
