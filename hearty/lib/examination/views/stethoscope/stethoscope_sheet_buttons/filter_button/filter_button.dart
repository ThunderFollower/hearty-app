import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/views.dart';
import '../../../../examination.dart';
import '../../../record/playback_controls/filters_extension.dart';
import '../../providers.dart';
import '../../stethoscope_controller.dart';

// TODO: [STT-1628] Implement reusable render logic for FilterButton
// Reusable render logic will bring separation-of-concerns and testability
// benefits.
// If the `filter` property is provided to the constructor,
// the result should be a change callback.
//
// I suggest replacing:
// ```
//     onPressed: () => ref
//                .read(stethoscopeControllerProvider.notifier)
//                .setActiveFilter(filter),
// ```
// to
//      onPressed: () => callback(),
//
class FilterButton extends ConsumerWidget {
  const FilterButton({
    super.key,
    required this.filter,
    this.internalKey,
    this.nameId = 'filter_btn',
  });

  final String nameId;
  final Filters filter;
  final Key? internalKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(stethoscopeStateProvider.notifier);
    final isActive = ref.watch(
      stethoscopeStateProvider.select(
        (value) => value.activeFilter == filter,
      ),
    );

    final theme = Theme.of(context);

    return Column(
      children: [_buildIcon(controller, isActive, theme), _buildText(theme)],
    );
  }

  Widget _buildText(ThemeData theme) {
    final textColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.bodySmall?.copyWith(color: textColor);

    final text = Text(filter.buttonText, style: textStyle);
    final fittedBox = FittedBox(fit: BoxFit.scaleDown, child: text);

    return SizedBox(width: _defaultSize, child: fittedBox);
  }

  Widget _buildIcon(
    StethoscopeController controller,
    bool isActive,
    ThemeData theme,
  ) {
    final button = _buildButton(controller, isActive, theme);

    return SizedBox(width: _defaultSize, height: _defaultSize, child: button);
  }

  Widget _buildButton(
    StethoscopeController controller,
    bool isActive,
    ThemeData theme,
  ) {
    final activeButtonColor = theme.colorScheme.secondary;
    final inactiveButtonColor = theme.colorScheme.outline;
    final activeIconColor = theme.colorScheme.primaryContainer;

    final textForDebugging = Text(
      isActive ? 'selected' : 'unselected',
      style: const TextStyle(fontSize: 0),
      overflow: TextOverflow.clip,
    );
    final colorFilter = ColorFilter.mode(
      isActive ? activeIconColor : activeButtonColor,
      BlendMode.srcIn,
    );
    final svgPicture = SvgPicture.asset(
      filter.iconPath,
      colorFilter: colorFilter,
    );

    final stack = Stack(children: [svgPicture, textForDebugging]);

    return RoundFilledButton(
      id: nameId,
      key: internalKey,
      size: _defaultSize,
      onPressed: () => controller.setActiveFilter(filter),
      color: isActive ? activeButtonColor : inactiveButtonColor,
      child: stack,
    );
  }
}

const _defaultSize = 54.0;
