/// Defines the interface for a controller that manages application updates,
/// including directing the user to the store for updates.
abstract class UpdaterController {
  /// Opens the application's page in the appropriate store to allow the user
  /// to update the application.
  void openStore();
}
