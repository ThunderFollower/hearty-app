import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [InternalServerErrorException] is thrown when the server responds
/// with a 500 status.
class InternalServerErrorException extends HttpException {
  static const int httpErrorCode = HttpStatus.internalServerError;

  /// Constructs a new [InternalServerErrorException] with an optional [response, details].
  const InternalServerErrorException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfInternalServerErrorException;
}
