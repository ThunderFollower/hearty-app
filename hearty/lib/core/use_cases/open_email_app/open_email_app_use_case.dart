/// Represents an abstract command to open an email application.
///
/// This abstract class defines a contract for implementations that open an
/// email application. Implementations can be platform-specific or
/// application-specific.
abstract class OpenEmailAppUseCase {
  /// Executes the command to open an email application.
  ///
  /// When executed, this function opens an email application. If a [mailTo]
  /// address is provided, the email application is pre-filled with this address.
  /// Otherwise, the email application opens with a blank new email.
  ///
  /// [mailTo] is an optional parameter. If provided, it should be a valid
  /// email address that the email application will use to pre-fill the recipient field.
  ///
  /// Returns a [Future] that completes when the email application has been opened.
  ///
  /// Throws an exception if the email application cannot be opened or if the provided
  /// [mailTo] address is invalid.
  Future<void> execute([String? mailTo]);
}
