import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [RequestTimeoutException] is thrown when the server responds
/// with a 408 status.
class RequestTimeoutException extends HttpException {
  static const int httpErrorCode = HttpStatus.requestTimeout;

  /// Constructs a new [RequestTimeoutException] with an optional [response, details].
  const RequestTimeoutException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfRequestTimeoutException;
}
