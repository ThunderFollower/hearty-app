import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'app_logger.dart';

class ConsoleLogger extends AppLogger {
  ConsoleLogger();

  final Logger _logger = Logger(level: Level.info, printer: PrettyPrinter());

  @override
  void writeOnRequest(RequestOptions options) {
    _logger.i(
      '''
      REQUEST:
      PATH ${options.path}
      METHOD ${options.method}
      BODY: ${options.data ?? ''}
      ''',
    );
  }

  @override
  void writeOnError(DioException error) {
    _logger.e(
      '''
      API ERROR:
      PATH: ${error.requestOptions.path}
      STATUS CODE: ${_resolveStatus(error)}
      ${error.response ?? ''}
      ''',
      error,
    );
  }

  int _resolveStatus(DioException err) => err.response?.statusCode ?? 0;
}
