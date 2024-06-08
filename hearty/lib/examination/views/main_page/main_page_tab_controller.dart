import 'package:flutter/material.dart';

/// Encapsulates presentation logic for the main page.
abstract class MainPageTabController {
  TabController getController(int length, TickerProvider ticker);
}
