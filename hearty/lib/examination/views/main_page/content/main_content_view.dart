import 'package:flutter/material.dart';

/// A page view that displays the widget corresponds to the currently selected
/// tab on the main tab bar.
///
/// This widget is used as a page view for the [MainContent].
class MainContentView extends StatelessWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [children] must be the same as the corresponding property
  /// of the controller.
  ///
  /// See [DefaultTabController] for more information.
  const MainContentView({
    super.key,
    required this.children,
    required this.controller,
  });

  /// One widget per tab.
  ///
  /// Its length must match the [MainContentTabBar.tabs] list and
  /// [DefaultTabController.length].
  final List<Widget> children;

  /// Tab controller
  final TabController controller;

  @override
  Widget build(BuildContext context) => Expanded(
        child: TabBarView(
          controller: controller,
          children: children,
        ),
      );
}
