import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../../../core/views.dart';
import '../../../examination.dart';
import '../../examination/body/modal_menu/modal_menu.dart';
import 'filters_extension.dart';

part 'playback_controls_filter_skeleton.dart';
part 'playback_controls_play_icon.dart';
part 'playback_controls_play_skeleton.dart';
part 'playback_controls_play.dart';
part 'playback_controls_speed.dart';

const _playButtonSize = Size(belowHightIndent * 2, belowHightIndent * 2);
const _iconSize = middleIndent;
final _speedFormatter = NumberFormat('0.0#');

class PlaybackControls extends ConsumerWidget {
  const PlaybackControls({
    this.filter,
    this.onFilterChanged,
    this.audioUri,
    this.isAdvancedMode,
    this.isPlaying,
    this.onPlay,
    this.speed,
    this.onSpeedChanged,
  });

  /// The filter applied to the current record.
  final Filters? filter;

  final void Function(Filters value)? onFilterChanged;

  /// The URI for the audio file associated with this record.
  final String? audioUri;

  /// Indicates if the advanced mode is active.
  final bool? isAdvancedMode;

  /// Indicates if audio playback is currently active.
  final bool? isPlaying;

  final VoidCallback? onPlay;

  final double? speed;

  final VoidCallback? onSpeedChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: isAdvancedMode == true
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (isAdvancedMode == true)
            _SpeedButton(
              key: _speedButtonKey,
              speed: speed,
              onSpeedChanged: onSpeedChanged,
            ),
          _PlayButton(onPlay: onPlay, isPlaying: isPlaying),
          if (isAdvancedMode == true) _buildFilterButton(context, ref, theme),
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    WidgetRef ref,
    ThemeData theme,
  ) {
    if (filter == null || onFilterChanged == null) {
      return const _FilterButtonSkeleton();
    }

    final color = theme.colorScheme.onTertiary;
    final colorFilter = ColorFilter.mode(color, BlendMode.srcIn);

    final buttonStyle = ElevatedButton.styleFrom(
      alignment: Alignment.center,
      fixedSize: const Size.fromRadius(belowHightIndent),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
    final svgPicture = SvgPicture.asset(
      filter!.iconPath,
      colorFilter: colorFilter,
      width: middleIndent,
      height: middleIndent,
    );

    return ElevatedButton(
      key: const Key('record_playback_controls_menu_button'),
      onPressed: () => _onMenuButtonPressed(context),
      style: buttonStyle,
      child: svgPicture,
    );
  }

  void _onMenuButtonPressed(BuildContext context) {
    if (filter == null || onFilterChanged == null) return;

    final actions = Filters.values.map(
      (element) => () => onFilterChanged?.call(element),
    );
    final labels = Filters.values.map((element) => element.name);

    final modalMenu = ModalMenu(
      currentLabel: filter?.name,
      labels: labels,
      icons: _buildIcons(context),
      actions: actions,
    );

    showModalDialog(context: context, child: modalMenu);
  }

  Iterable<SvgPicture> _buildIcons(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    const mode = BlendMode.srcIn;
    final colorFilter = ColorFilter.mode(scheme.secondary, mode);
    final selectedColorFilter = ColorFilter.mode(scheme.onSecondary, mode);

    return Filters.values.map(
      (element) {
        final currentColorFilter =
            filter?.index == element.index ? selectedColorFilter : colorFilter;
        return SvgPicture.asset(
          element.iconPath,
          width: _iconSize,
          height: _iconSize,
          colorFilter: currentColorFilter,
        );
      },
    );
  }
}

// Key
const _speedButtonKey = Key('speed_button_key');
