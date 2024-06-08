/// Defines a controller for a page with an e-mail input field.
abstract class EmailEnteringController {
  /// Execute an action when the user has entered an [email].
  Future<void> execute(String email);
}
