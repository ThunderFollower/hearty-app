import 'constants.dart';

/// A [CanceledException] is thrown when a request is canceled.
class CanceledException implements Exception {
  /// Constructs a new [CanceledException].
  const CanceledException({this.reason, this.details});

  /// The reason of the cancellation.
  final String? reason;

  /// Detailed information on the exception.
  final String? details;

  @override
  String toString() => reason ?? defaultCancellationReason;
}
