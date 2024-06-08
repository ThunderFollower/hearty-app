import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../cancelable.dart';
import '../exceptions/index.dart';
import '../http_data_source.dart';
import '../serializable.dart';
import 'http_cancel_token.dart';

/// Defines an adapter of the [HttpDataSource] port that is used a [Dio] client.
class HttpDataSourceAdapter implements HttpDataSource {
  /// Constructs a new [HttpDataSourceAdapter] with the given [client].
  const HttpDataSourceAdapter(this.client);

  /// The [Dio] client used to make HTTP requests.
  final Dio client;

  /// Request data from the given [path] using the given [method].
  ///
  /// The [path] is the relative path to the resource.
  /// The [method] is the HTTP method to use.
  /// If [body] is not null, it will be serialized to JSON and added to the
  /// request.
  ///
  /// if [queryParameters] is not null, a query string will be added to the
  /// request.
  ///
  /// if [headers] are not null, the given header items will be added to
  /// the request.
  ///
  /// if [cancelable] is not null, it can be used to cancel the request.
  /// It must be either an instance of [HttpCancelToken] or derived from it.
  /// Ignored when [cancellationStream] is provided.
  ///
  /// [cancellationStream] can be provided to signal the cancellation
  /// of the request. Emitting a value in this stream will trigger
  /// the cancellation process.
  ///
  /// if [deserializer] is not null, it will be used to deserialize the
  /// response data, otherwise it will be cast to the type of [T]
  ///
  /// Returns a [Future] that completes with the deserialized value.
  @protected
  Future<T> request<T>(
    String path, {
    required String method,
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) async {
    cancelable = cancellationStream != null ? HttpCancelToken() : cancelable;
    final subscription = cancellationStream?.listen((_) {
      cancelable?.cancel();
    });

    try {
      final options = _buildRequestOptions(
        path,
        method: method,
        headers: headers,
        body: body,
        queryParameters: queryParameters,
        cancelable: cancelable,
      );

      final data = await fetch(options);
      return deserialize(deserializer, data);
    } finally {
      subscription?.cancel();
    }
  }

  RequestOptions _buildRequestOptions(
    String path, {
    required String method,
    Serializable? headers,
    Serializable? body,
    Serializable? queryParameters,
    Cancelable? cancelable,
  }) {
    assert(
      cancelable == null || cancelable is HttpCancelToken,
      '[cancelable] must be an instance of HttpCancelToken',
    );

    final options = Options(
      method: method,
      headers: headers?.toJson(),
    ).compose(
      client.options,
      path,
      data: body?.toJson(),
      queryParameters: queryParameters?.toJson(),
      cancelToken: cancelable as HttpCancelToken?,
    );
    return options;
  }

  /// Fetch an object.
  ///
  /// The [options] are the options to use for the request.
  ///
  /// Returns a [Future] that completes with a JSON object.
  @protected
  Future<dynamic> fetch(RequestOptions options) async {
    try {
      final response = await client.fetch(options);
      return response.data;
    } on DioException catch (error) {
      // DioException should be wrapped into known application exceptions,
      // based on the error reason, to handle them in the User Interface
      // or Application layers.
      // When the server responds with an error status code, the error will be
      // wrapped into a [HttpException].
      // The CanceledException should be thrown when the request is canceled.
      // The RequestTimeoutException should be thrown when there is a timeout.
      // For the other reason, the error will be kept unchanged.
      if (error.response != null &&
          error.type == DioExceptionType.badResponse) {
        throw HttpException.fromResponse(error.response!);
      } else if (error.type == DioExceptionType.cancel) {
        throw CanceledException(details: '${options.method} ${options.path}');
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        throw const RequestTimeoutException();
      }
      rethrow;
    }
  }

  /// Deserialize the given [data] using the given [deserializer].
  @protected
  T deserialize<T>(DeserializeValue<T>? deserializer, dynamic data) {
    if (deserializer == null) return data as T;
    if (data == null) throw const MalformedResponseException();
    return deserializer(data as Json);
  }

  @override
  Future<T> get<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) =>
      request(
        path,
        method: 'GET',
        queryParameters: queryParameters,
        headers: headers,
        cancelable: cancelable,
        cancellationStream: cancellationStream,
        deserializer: deserializer,
      );

  @override
  Future<T> post<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) =>
      request(
        path,
        method: 'POST',
        queryParameters: queryParameters,
        body: body,
        headers: headers,
        cancelable: cancelable,
        cancellationStream: cancellationStream,
        deserializer: deserializer,
      );

  @override
  Future<T> put<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) =>
      request(
        path,
        method: 'PUT',
        queryParameters: queryParameters,
        body: body,
        headers: headers,
        cancelable: cancelable,
        cancellationStream: cancellationStream,
        deserializer: deserializer,
      );

  @override
  Future<T> delete<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) =>
      request(
        path,
        method: 'DELETE',
        queryParameters: queryParameters,
        headers: headers,
        cancelable: cancelable,
        cancellationStream: cancellationStream,
        deserializer: deserializer,
      );

  @override
  Future<T> patch<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  }) =>
      request(
        path,
        method: 'PATCH',
        queryParameters: queryParameters,
        body: body,
        headers: headers,
        cancelable: cancelable,
        cancellationStream: cancellationStream,
        deserializer: deserializer,
      );
}
