import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [ConflictException] is thrown when the server responds
/// with a 409 status.
class ConflictException extends HttpException {
  static const int httpErrorCode = HttpStatus.conflict;

  /// Constructs a new [ConflictException] with an optional [response, details].
  const ConflictException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfConflictException;
}
