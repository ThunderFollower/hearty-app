import 'application_metadata.dart';

/// Defines the interface for repositories capable of fetching application metadata.
abstract class ApplicationMetadataRepository {
  /// Finds all application metadata matching the specified package name,
  /// optionally cancelable by the provided stream.
  Stream<Iterable<ApplicationMetadata>> findAll(
    String packageName, [
    Stream<void>? cancellation,
  ]);
}
