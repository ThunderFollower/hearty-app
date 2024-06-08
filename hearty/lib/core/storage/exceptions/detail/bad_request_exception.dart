import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [BadRequestException] is thrown when the server responds with a 400 status.
class BadRequestException extends HttpException {
  static const int httpErrorCode = HttpStatus.badRequest;

  /// Constructs a new [BadRequestException] with an optional [response, details].
  const BadRequestException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfBadRequestException;
}
