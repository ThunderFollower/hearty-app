import 'package:dio/dio.dart';

abstract class AppLogger {
  void writeOnRequest(RequestOptions options);
  void writeOnError(DioException error);
}
