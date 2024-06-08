import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'foundation_page_controller.dart';

/// Adapts [FoundationPageController] to work with [StackRouter].
class FoundationPageControllerAdapter implements FoundationPageController {
  /// Creates an adapter for controlling page navigation.
  ///
  /// Requires a [StackRouter] instance to manage navigation.
  FoundationPageControllerAdapter({
    required this.router,
  });

  @protected
  final StackRouter router;

  @override
  void dismiss() {
    if (router.canPop()) router.pop();
  }
}
