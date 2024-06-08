import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../state/landing_state_provider.dart';
import 'skeletons/stethoscope_button_skeleton.dart';

/// A custom button that, when clicked, triggers the stethoscope functionality.
///
/// This widget depends on the state of the application to determine if the
/// stethoscope functionality can be triggered. If so, it shows the
/// stethoscope button; otherwise, it shows a loading skeleton.
class StethophoneButtonWidget extends ConsumerWidget {
  const StethophoneButtonWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(landingStateProvider);
    final controller = ref.watch(landingStateProvider.notifier);

    return state.canOpenStethoscope.maybeWhen(
      data: (data) => data
          ? StethoscopeButton(onTap: controller.openStethoscope)
          : const SizedBox.shrink(),
      orElse: () => const StethophoneButtonSkeleton(),
    );
  }
}
