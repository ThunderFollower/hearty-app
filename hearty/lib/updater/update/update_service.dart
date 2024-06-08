/// Defines the interface for a service that observes application updates.
abstract class UpdateService {
  /// Returns a stream that emits a boolean value indicating whether
  /// an update is available.
  Stream<bool> observeUpdate();
}
