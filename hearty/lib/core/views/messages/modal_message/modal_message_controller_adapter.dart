import 'package:auto_route/auto_route.dart';

import 'modal_message_controller.dart';

/// Encapsulates event handling for the Modal Message page.
class ModalMessageControllerAdapter extends ModalMessageController {
  /// Create a [ModalMessageControllerAdapter] with the given [router].
  const ModalMessageControllerAdapter(StackRouter router) : _router = router;

  /// The application's router to manage the navigation.
  final StackRouter _router;

  /// Dismiss the current page.
  @override
  void dismiss() {
    _router.pop();
  }
}
