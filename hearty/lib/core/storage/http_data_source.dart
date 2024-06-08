import 'cancelable.dart';
import 'serializable.dart';

/// Deserialize value from JSON.
typedef DeserializeValue<T> = T Function(Json);

/// Defines a contract of a Data Source that can be used to fetch data via HTTP.
/// It supports GET, POST, PUT, DELETE, PATCH, and HEAD requests.
abstract class HttpDataSource {
  /// Fetch an object from the data source under the specified [path].
  ///
  /// if [queryParameters] is not null, a query string will be added to the
  /// request.
  ///
  /// if [headers] are not null, the given header items will be added to
  /// the request.
  ///
  /// if [cancelable] is not null, it can be used to cancel the request.
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
  ///
  /// Throws an [Exception] if the request fails.
  Future<T> get<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  });

  /// Post data to the data source under the specified [path].
  ///
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
  ///
  /// Throws an [Exception] if the request fails.
  Future<T> post<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  });

  /// Put an object to the data source under the specified [path].
  ///
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
  ///
  /// Throws an [Exception] if the request fails.
  Future<T> put<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  });

  /// Delete an object from the data source under the specified [path].
  ///
  /// if [queryParameters] is not null, a query string will be added to the
  /// request.
  ///
  /// if [headers] are not null, the given header items will be added to
  /// the request.
  ///
  /// if [cancelable] is not null, it can be used to cancel the request.
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
  ///
  /// Throws an [Exception] if the request fails.
  Future<T> delete<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  });

  /// Patch an object to the data source under the specified [path].
  ///
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
  /// Throws an [Exception] if the request fails.
  Future<T> patch<T>(
    String path, {
    Serializable? queryParameters,
    Serializable? body,
    Serializable? headers,
    Cancelable? cancelable,
    Stream? cancellationStream,
    DeserializeValue<T>? deserializer,
  });
}
