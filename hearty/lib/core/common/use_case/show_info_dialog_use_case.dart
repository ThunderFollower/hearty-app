/// Defines the interface for showing an alert dialog.
abstract class ShowAlertUseCase {
  /// Shows an alert dialog with the given [title] and an optional [buttonTitle].
  ///
  /// If [onPressed] is provided, it will be called when the button in the
  /// dialog is pressed.
  ///
  /// The [onPressed] function takes no arguments and returns nothing.
  ///
  /// Returns a [Future] that completes when the dialog is closed.
  Future<T?> execute<T>({
    required String title,
    String? buttonTitle,
    void Function()? onPressed,
  });
}
