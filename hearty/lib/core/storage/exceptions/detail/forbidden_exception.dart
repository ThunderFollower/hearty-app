import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [ForbiddenException] is thrown when the server responds
/// with a 403 status.
class ForbiddenException extends HttpException {
  static const int httpErrorCode = HttpStatus.forbidden;

  /// Constructs a new [ForbiddenException] with an optional [response, details].
  const ForbiddenException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfForbiddenException;
}
