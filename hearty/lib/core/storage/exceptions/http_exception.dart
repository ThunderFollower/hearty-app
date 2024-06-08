import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'detail/index.dart';

/// Defines the default exception that should be thrown when the server
/// responds with an error status code.
class HttpException implements Exception {
  /// Constructs a new [HttpException] with an optional [response].
  @protected
  const HttpException(this.statusCode, this.response, this.details);

  /// The received status code.
  final int? statusCode;

  /// The received response.
  final String? response;

  /// Detailed information on the exception.
  final String? details;

  @override
  String toString() {
    return 'HttpException: (statusCode: $statusCode, response: $response)';
  }

  /// Constructs a new [Exception] from a [response].
  static Exception fromResponse<T>(Response<T> response) {
    final statusCode = response.statusCode;
    final responseData = kDebugMode ? response.data.toString() : null;
    final options = response.requestOptions;
    final details = '${options.method} ${options.path}';
    switch (statusCode) {
      case HttpStatus.badRequest:
        return BadRequestException(response: responseData, details: details);
      case HttpStatus.unauthorized:
        return UnauthorizedException(response: responseData, details: details);
      case HttpStatus.forbidden:
        return ForbiddenException(response: responseData, details: details);
      case HttpStatus.notFound:
        return NotFoundException(response: responseData, details: details);
      case HttpStatus.requestTimeout:
        return RequestTimeoutException(
          response: responseData,
          details: details,
        );
      case HttpStatus.conflict:
        return ConflictException(response: responseData, details: details);
      case HttpStatus.locked:
        return LockedException(response: responseData, details: details);
      case HttpStatus.upgradeRequired:
        return UpgradeRequiredException(
          response: responseData,
          details: details,
        );
      case HttpStatus.tooManyRequests:
        return TooManyRequestsException(
          response: responseData,
          details: details,
        );
      case HttpStatus.internalServerError:
        return InternalServerErrorException(
          response: responseData,
          details: details,
        );
      case HttpStatus.serviceUnavailable:
        return ServiceUnavailableException(
          response: responseData,
          details: details,
        );
    }
    return HttpException(statusCode, responseData, details);
  }
}
