/// An exception that indicates that signing up has failed.
class SignUpException implements Exception {
  /// Create a new instance of [SignUpException] with the given error [message].
  const SignUpException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'SignUpException: $message';
}
