import 'constants.dart';

/// Defines an exception that is thrown when a response cannot be processed due
/// to malformed syntax.
class MalformedResponseException implements Exception {
  /// Create a new [MalformedResponseException] with an optional error [message].
  const MalformedResponseException({this.message, this.details});

  /// The message that describes the exception.
  final String? message;

  /// Detailed information on the exception.
  final String? details;

  @override
  String toString() => message ?? defaultMalformedResponseMessage;
}
