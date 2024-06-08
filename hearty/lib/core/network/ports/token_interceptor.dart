import 'package:dio/dio.dart';

/// Function signature for a callback when an access token is removed.
typedef OnRemoveToken = void Function();

/// Function signature for a callback when an access token needs to be refreshed.
typedef OnRefreshToken = Future<String?> Function();

/// Function signature for a callback to retry a request with refreshed access token.
typedef OnRetryRequest = Future<Response> Function(RequestOptions options);

/// An abstract class for token interceptor, which implements [Interceptor].
/// Provides an interface to handle access tokens, refresh, and retry logic.
abstract class TokenInterceptor implements Interceptor {
  /// The current access token.
  String? accessToken;

  /// The maximum number of times a request can be retried.
  int get maxRetryCount;
  set maxRetryCount(int value);

  /// A callback to be called when the access token is removed.
  OnRemoveToken? onRemoveToken;

  /// A callback to be called when the access token needs to be refreshed.
  OnRefreshToken? onRefresh;

  /// A callback to be called to retry a request with the refreshed access token.
  OnRetryRequest? onRetry;
}
