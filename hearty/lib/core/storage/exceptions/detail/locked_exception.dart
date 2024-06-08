import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [LockedException] is thrown when the server responds
/// with a 423 status.
class LockedException extends HttpException {
  static const int httpErrorCode = HttpStatus.locked;

  /// Constructs a new [LockedException] with an optional [response, details].
  const LockedException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfLockedException;
}
