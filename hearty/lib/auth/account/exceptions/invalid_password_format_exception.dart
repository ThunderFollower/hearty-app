/// An exception that indicates that password has an invalid format.
class InvalidPasswordFormatException implements Exception {
  /// Create a new instance of [InvalidPasswordFormatException] with the given error [message].
  const InvalidPasswordFormatException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'InvalidPasswordFormatException: $message';
}
