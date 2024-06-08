import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [ServiceUnavailableException] is thrown when the server responds
/// with a 503 status.
class ServiceUnavailableException extends HttpException {
  static const int httpErrorCode = HttpStatus.serviceUnavailable;

  /// Constructs a new [ServiceUnavailableException] with an optional [response, details].
  const ServiceUnavailableException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfServiceUnavailableException;
}
