import 'dart:io';

import 'package:dio/dio.dart';

import '../../../core/core.dart';
import '../dtos/constants.dart';

/// A token interceptor adapter for Dio which manages token refresh and retry
/// logic in case of HTTP unauthorized errors.
class TokenInterceptorAdapter extends QueuedInterceptor
    implements TokenInterceptor {
  @override
  String? accessToken;
  @override
  int maxRetryCount = 1;

  @override
  OnRemoveToken? onRemoveToken;
  @override
  OnRefreshToken? onRefresh;
  @override
  OnRetryRequest? onRetry;

  /// Inserts the access token into the request header.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers[authorizationHeaderName] = _authorizationHeader;
    handler.next(options);
  }

  /// Generates the authorization header value using the current access token.
  /// It combines the bearer token type with the access token to form the
  /// complete value expected in the authorization header of an HTTP request.
  String get _authorizationHeader => '$bearerTokenType $accessToken';

  /// Handles HTTP unauthorized errors by refreshing the token and retrying the
  /// request if possible.
  @override
  Future<void> onError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode != HttpStatus.unauthorized) {
      handler.next(error);
      return;
    }

    try {
      final options = error.requestOptions;
      if (_hasAccessTokenBeenUpdated(options) || await _refreshToken(options)) {
        await _retryRequest(error, handler);
      } else {
        throw error;
      }
    } catch (retryError) {
      _removeToken();
      handler.reject(retryError is DioException ? retryError : error);
    }
  }

  /// Refreshes the access token and verifies if it's possible to retry the
  /// request.
  Future<bool> _refreshToken(RequestOptions options) async {
    if (_isRetryLimitExceeded(options)) return false;

    accessToken = await onRefresh?.call();
    return accessToken != null;
  }

  /// Determines whether the access token has been changed since the last request.
  /// This method checks if the current access token is different from the
  /// token used in the previous request's authorization header.
  bool _hasAccessTokenBeenUpdated(RequestOptions options) =>
      accessToken != null &&
      options.headers[authorizationHeaderName] != _authorizationHeader;

  /// Retries a request with the refreshed token.
  Future<void> _retryRequest(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = error.requestOptions;
    _increaseRetryCount(requestOptions);

    final response = await onRetry?.call(requestOptions);
    if (response != null) {
      handler.resolve(response);
    } else {
      throw error;
    }
  }

  /// Checks if the retry limit for a request has been exceeded.
  bool _isRetryLimitExceeded(RequestOptions options) =>
      options.headers[_retryCount] == maxRetryCount;

  /// Increases the retry count for a request.
  void _increaseRetryCount(RequestOptions options) {
    final count = options.headers[_retryCount];
    options.headers[_retryCount] = (count is int) ? count + 1 : 1;
  }

  /// Clears the access token and triggers the onRemoveToken callback if provided.
  void _removeToken() {
    accessToken = null;
    onRemoveToken?.call();
  }
}

const _retryCount = 'Retry-Count';
