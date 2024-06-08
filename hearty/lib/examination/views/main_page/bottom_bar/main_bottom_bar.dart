import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import 'bottom_bar.dart';
import 'bottom_bar_button/bottom_bar_button.dart';
import 'circle_bottom_item/circle_bottom_item.dart';
import 'main_bottom_bar_controller.dart';
import 'main_bottom_bar_key.dart';
import 'main_bottom_bar_state.dart';
import 'main_bottom_bar_state_provider.dart';

final _stethoscopeLabel = LocaleKeys.Stethoscope.tr();
// final _examinationLabel = LocaleKeys.Examinations.tr();
const _newExaminationId = 'new_examination_btn';

/// The main application's bottom bar mimics a navigation bar. It appears at
/// the bottom of the
/// [Main Screen](https://www.figma.com/file/cl5H1hCakhD8teZTZ5XxpO/S---V2?node-id=12447%3A25204).
class MainBottomBar extends ConsumerWidget {
  /// Creates a [BottomBar] for the Main Screen.
  const MainBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainBottomBarStateProvider);
    final controller = ref.read(mainBottomBarStateProvider.notifier);

    if (state.isDoctorMode) return _buildForDoctor(controller, state);
    return _buildForPatient(controller, state);
  }

  Widget _buildForDoctor(
    MainBottomBarController controller,
    MainBottomBarState state,
  ) {
    return BottomBar(
      key: mainBottomBarKey,
      items: [
        _buildStethoscopeItem(controller, state),
        _buildNewExaminationItem(controller, state),
        _buildInvisibleItem(),
      ],
    );
  }

  Widget _buildInvisibleItem() => const SizedBox(
        key: Key('invisible_item'),
        width: _itemWidth,
        height: _itemHeight,
      );

  Widget _buildForPatient(
    MainBottomBarController controller,
    MainBottomBarState state,
  ) {
    return BottomBar(
      key: mainBottomBarKey,
      mainAxisAlignment: MainAxisAlignment.center,
      items: [_buildNewExaminationItem(controller, state)],
    );
  }

  Widget _buildStethoscopeItem(
    MainBottomBarController controller,
    MainBottomBarState state,
  ) {
    VoidCallback? onStethoscope;
    if (state.isEnabled) {
      onStethoscope = controller.handleStethoscopeItemSelection;
    }

    // We open a modal popup of the Stethoscope by tapping the below item. It
    // will overlay the bottom bar. Therefore we should not update the
    // selection.
    return BottomBarButton(
      selected: true,
      key: const Key('stethoscope'),
      assetPath: 'assets/images/live.svg',
      onTap: onStethoscope,
      label: _stethoscopeLabel,
    );
  }

  Widget _buildNewExaminationItem(
    MainBottomBarController controller,
    MainBottomBarState state,
  ) {
    VoidCallback? onNewExamination;
    if (state.isEnabled) {
      onNewExamination = controller.handleNewExaminationItemSelection;
    }

    // We open a modal popup to create a new examination by tapping the below
    // item. It will overlay the bottom bar as well. Therefore we should not
    // update the selection.
    final newExaminationItem = CircleBottomItem(
      icon: AppIcons.add,
      onPressed: onNewExamination,
    );

    // This locator helps to find the "New Examination" item (button) when
    // testing the application with end-2-end tests.
    return AppLocator(id: _newExaminationId, child: newExaminationItem);
  }
}

const _itemWidth = 88.0;
const _itemHeight = 46.0;
