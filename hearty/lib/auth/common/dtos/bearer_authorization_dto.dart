import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import 'constants.dart';

/// Defines the Data Transfer Object of authorization by a Bearer token.
@immutable
class BearerAuthorizationDto implements Serializable<BearerAuthorizationDto> {
  /// Access tokens are used in token-based authentication to allow
  /// the application to access an API.
  final String accessToken;

  /// Initialize a new [BearerAuthorizationDto] object with [accessToken].
  const BearerAuthorizationDto(this.accessToken);

  /// Serialize this object and return a JSON object.
  @override
  Map<String, dynamic> toJson() => {
        authorizationHeaderName: '$bearerTokenType $accessToken',
      };

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BearerAuthorizationDto &&
            other.accessToken == accessToken);
  }

  @override
  int get hashCode => accessToken.hashCode;
}
