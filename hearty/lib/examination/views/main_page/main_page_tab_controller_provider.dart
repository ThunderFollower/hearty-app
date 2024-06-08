import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../examination/index.dart';
import 'main_page_controller.dart';
import 'main_page_tab_controller.dart';
import 'main_page_tab_controller_adapter.dart';

/// Defines provider for the [MainPageController].
final mainPageTabControllerProvider =
    Provider.autoDispose<MainPageTabController>(
  (ref) {
    final examinationListenable =
        examinationStateProvider.select((value) => value.isReceived);
    final isExamReceivedOne = ref.watch(examinationListenable);
    final currentIndex = isExamReceivedOne ? 1 : 0;
    return MainPageTabControllerAdapter(index: currentIndex);
  },
);
