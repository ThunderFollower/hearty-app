import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../core/views.dart';
import 'providers.dart';
import 'record_tile_state.dart';

part 'record_tile_content.dart';
part 'record_tile_header_layout.dart';
part 'record_tile_heart_rate.dart';
part 'record_tile_skeleton.dart';
part 'record_tile_spot_mark.dart';
part 'record_tile_timestamp.dart';

class RecordTile extends ConsumerWidget {
  const RecordTile({super.key, required this.recordId});

  final String recordId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = recordTileStateProvider(recordId);
    final state = ref.watch(provider);
    final controller = ref.watch(provider.notifier);

    final theme = Theme.of(context);

    final backgroundColor = theme.colorScheme.primary;

    final boxDecoration = BoxDecoration(
      color: backgroundColor,
      borderRadius: _borderRadius,
    );

    final child = state.spotName == null
        ? const _TileSkeleton()
        : Container(
            padding: _innerPadding,
            decoration: boxDecoration,
            child: _buildContent(state),
          );

    return GestureDetector(onTap: controller.openRecordReport, child: child);
  }

  Widget _buildContent(RecordTileState state) {
    final error = state.error;
    if (error != null) {
      return Text(error, textAlign: TextAlign.center);
    } else {
      final header = _HeaderLayout(
        spot: _SpotMark(name: state.spotName, number: state.spotNumber),
        timestamp: _Timestamp(state.createdAt),
        heartRate: _HeartRate(state.heartRate),
      );

      final iconPath = state.assetPath;
      final icon = iconPath != null ? LocalImage(assetPath: iconPath) : null;
      _TileContent(icon: icon, text: state.finding);

      return Column(
        children: [
          header,
          const SizedBox(height: lowestIndent),
          _TileContent(icon: icon, text: state.finding),
        ],
      );
    }
  }
}

const _borderRadius = BorderRadius.all(Radius.circular(lowIndent));
const _innerPadding = EdgeInsets.symmetric(
  horizontal: belowLowIndent,
  vertical: lowIndent,
);
const _smallestIndent = 4.0;
const _heartRateIconPath = 'assets/images/heart_rate.svg';
