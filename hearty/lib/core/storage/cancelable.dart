/// Defines a contract for an object that can be canceled.
abstract class Cancelable {
  /// Cancel the object.
  void cancel([dynamic reason]);
}
