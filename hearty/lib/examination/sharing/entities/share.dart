/// Defines an entity object that represents the sharing data.
abstract class Share {
  /// The unique identifier of the shared object.
  String get id;

  /// The timestamp of the resource creation, as specified in ISO 8601.
  DateTime get createdAt;

  /// The timestamp of the resource expiration date, as specified in ISO 8601.
  DateTime get expiresAt;

  /// The permanent deep link to the resource.
  Uri get link;
}
