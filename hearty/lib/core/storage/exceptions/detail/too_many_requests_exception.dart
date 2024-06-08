import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [TooManyRequestsException] is thrown when the server responds
/// with a 429 status.
class TooManyRequestsException extends HttpException {
  static const int httpErrorCode = HttpStatus.tooManyRequests;

  /// Constructs a new [TooManyRequestsException] with an optional [response, details].
  const TooManyRequestsException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfTooManyRequestsException;
}
