import 'dart:io';

import '../http_exception.dart';

const _description = 'The request has not been completed because it lacks'
    ' valid authentication credentials for the requested resource.';

/// A [UnauthorizedException] is thrown when the server responds
/// with a 401 status.
class UnauthorizedException extends HttpException {
  static const int httpErrorCode = HttpStatus.unauthorized;

  /// Constructs a new [UnauthorizedException] with an optional [response, details].
  const UnauthorizedException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? _description;
}
