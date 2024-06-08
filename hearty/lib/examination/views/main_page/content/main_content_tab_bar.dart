import 'package:flutter/material.dart';

const _tabHeight = 32.0;
final _borderRadius = BorderRadius.circular(16.0);
const _padding = EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 16);

/// A widget that displays a horizontal row of tabs.
///
/// This widget is used as a page view for the [MainContent].
///
/// It uses [ColorScheme.tertiary] as the background color.
///
/// It uses [TextTheme.bodyLarge] to configure [TabBar.labelStyle] and
/// [TabBar.unselectedLabelStyle].
class MainContentTabBar extends StatelessWidget {
  /// Creates a page view with one child per tab.
  ///
  /// The length of [tabs] must be the same as the corresponding property
  /// of the controller.
  ///
  /// See [DefaultTabController] for more information.
  const MainContentTabBar({
    super.key,
    required this.tabs,
    required this.controller,
  });

  /// A list of two or more [Tab] widgets.
  ///
  /// Its length must match the [MainContentView.children] list and
  /// [DefaultTabController.length].
  final List<Widget> tabs;

  /// Tab controller
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final tabBar = TabBar(
      controller: controller,
      tabs: tabs,
      labelStyle: theme.textTheme.bodyLarge,
      unselectedLabelStyle: theme.textTheme.bodyLarge,
    );

    final decoration = BoxDecoration(
      color: theme.colorScheme.tertiary,
      borderRadius: _borderRadius,
    );
    final tabContainer = Container(
      height: _tabHeight,
      decoration: decoration,
      child: tabBar,
    );

    return Container(
      padding: _padding,
      child: tabContainer,
    );
  }
}
