import 'package:flutter/material.dart';

import 'main_page_controller.dart';
import 'main_page_tab_controller.dart';

/// Implements the [MainPageController] contract.
class MainPageTabControllerAdapter extends MainPageTabController {
  /// Creates the controller for the main page that deals with system events.
  MainPageTabControllerAdapter({
    required this.index,
  }) : super();

  final int index;

  TabController? _controller;

  @override
  TabController getController(int length, TickerProvider ticker) {
    _controller ??= TabController(
      initialIndex: index,
      length: length,
      vsync: ticker,
    );
    return _controller!;
  }
}
