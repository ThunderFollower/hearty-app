import 'dart:io';

import '../http_exception.dart';
import 'constant.dart';

/// A [UpgradeRequiredException] is thrown when the server responds
/// with a 426 status.
class UpgradeRequiredException extends HttpException {
  static const int httpErrorCode = HttpStatus.upgradeRequired;

  /// Constructs a new [UpgradeRequiredException] with an optional [response, details].
  const UpgradeRequiredException({String? response, String? details})
      : super(httpErrorCode, response, details);

  @override
  String toString() => response ?? descriptionOfUpgradeRequiredException;
}
