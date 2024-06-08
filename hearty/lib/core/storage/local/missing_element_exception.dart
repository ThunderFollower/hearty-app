/// This exception is thrown when the server when an element is missing from
/// storage.
class MissingElementException implements Exception {
  /// The name of the missing element.
  final String elementName;

  /// Construct a [MissingElementException] and initialize it with the given
  /// [elementName].
  const MissingElementException(this.elementName);

  @override
  String toString() => 'The $elementName element is missing';
}
