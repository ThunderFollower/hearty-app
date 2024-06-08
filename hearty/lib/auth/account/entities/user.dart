/// Defines an entity object that represents the application user.
abstract class User {
  /// Unique identifier of the user.
  String get id;

  /// The user email address for login
  String get email;
}
