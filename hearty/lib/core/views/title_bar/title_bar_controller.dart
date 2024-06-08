import 'package:auto_route/auto_route.dart';

/// Defines the controller of a title bar.
class TitleBarController {
  /// The application's router to manage the navigation.
  final StackRouter _router;

  /// Create a [TitleBarController] with the given [_router].
  TitleBarController(this._router);

  /// Returns whether or not the [TitleBarController] can navigate back.
  bool get canNavigateBack => _router.canNavigateBack;

  /// Navigate to the previous page.
  void navigateBack() {
    _router.pop();
  }
}
