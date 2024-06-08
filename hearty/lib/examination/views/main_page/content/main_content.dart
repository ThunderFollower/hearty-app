import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../examination_root/tab/list/examination_list.dart';
import '../main_page_tab_controller_provider.dart';
import 'main_content_key.dart';
import 'main_content_tab_bar.dart';
import 'main_content_view.dart';

const _borderRadius = BorderRadius.vertical(top: Radius.circular(24));
final _myExaminationsLabel = LocaleKeys.My_Examinations.tr();

/// A view displays the content of the
/// [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=12447%3A25204).
///
/// It includes a [TabBar] with pages.
class MainContent extends ConsumerStatefulWidget {
  /// Create a view displays the content of the
  /// [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=12447%3A25204)
  /// with a [TabBar] with pages.
  const MainContent({super.key});

  @override
  ConsumerState<MainContent> createState() => _MainContentState();
}

class _MainContentState extends ConsumerState<MainContent>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final tabMap = _buildTabs();
    final controller = ref.watch(mainPageTabControllerProvider);
    final tabController = controller.getController(tabMap.length, this);

    final theme = Theme.of(context);
    final tabView = MainContentView(
      key: mainContentKey,
      controller: tabController,
      children: tabMap.values.toList(),
    );

    final tabBar = MainContentTabBar(
      tabs: tabMap.keys.toList(),
      controller: tabController,
    );

    final tabRoot = Column(children: [tabBar, tabView]);

    final decoration = BoxDecoration(
      borderRadius: _borderRadius,
      color: theme.colorScheme.primaryContainer,
    );
    return Container(
      decoration: decoration,
      child: tabRoot,
    );
  }

  Map<Tab, Widget> _buildTabs() {
    const mine = ExaminationList();

    const column1 = Column(children: [mine]);

    final tab1 = Tab(key: _myExaminationsKey, text: _myExaminationsLabel);

    return {tab1: column1};
  }
}

// Keys
const _myExaminationsKey = Key('my_examinations_key');
