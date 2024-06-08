import 'package:dio/dio.dart';

import '../cancelable.dart';

/// Encapsulates a logic to cancel an HTTP request.
class HttpCancelToken extends CancelToken implements Cancelable {
  /// Constructs a new instance of [HttpCancelToken].
  HttpCancelToken();
}
