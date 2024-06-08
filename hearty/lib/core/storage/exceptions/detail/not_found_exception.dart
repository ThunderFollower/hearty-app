import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [NotFoundException] is thrown when the server responds
/// with a 404 status.
class NotFoundException extends HttpException {
  static const int httpErrorCode = HttpStatus.notFound;

  /// Constructs a new [NotFoundException] with an optional [response, details].
  const NotFoundException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfNotFoundException;
}
