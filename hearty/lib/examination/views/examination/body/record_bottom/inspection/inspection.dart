import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import '../../../../../record/index.dart';
import '../record_bottom.dart';
import 'config/inspection_controller_provider.dart';
import 'inspection_controller.dart';
import 'inspection_skeleton.dart';
import 'inspection_state.dart';
import 'items/inspection_content.dart';
import 'items/inspection_header.dart';

/// A widget representing the header of an existing record.
class Inspection extends ConsumerWidget {
  /// Constructs an [Inspection].
  ///
  /// The [mutable] parameter specifies whether the record is mutable or not.
  /// It is set to `true` by default.

  const Inspection({
    required this.recordId,
    required this.bodyPosition,
    this.mutable = true,
  });

  final String recordId;
  final BodyPosition bodyPosition;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = InspectionParameters(recordId, mutable);
    final provider = inspectionControllerProvider(params);
    final controller = ref.watch(provider.notifier);
    final state = ref.watch(provider);

    final mediaQuery = MediaQuery.of(context);
    final height = RecordBottom.screenHeightQuotient * mediaQuery.size.height;
    final bottomPadding = _getBottomPadding(mediaQuery);

    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.onSecondary;

    final decoration = BoxDecoration(
      borderRadius: _borderRadius,
      color: backgroundColor,
    );
    final padding = EdgeInsets.only(
      bottom: bottomPadding,
      top: aboveLowestIndent,
    );
    return Container(
      height: height,
      width: mediaQuery.size.width,
      padding: padding,
      decoration: decoration,
      child: _buildBody(state, controller, theme),
    );
  }

  Widget _buildBody(
    InspectionState state,
    InspectionController controller,
    ThemeData theme,
  ) {
    if (state.createdAt == null || state.isFine == null) {
      return const InspectionSkeleton();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildHeader(state, controller),
        _buildContent(state, controller),
        _buildPlayButton(controller, theme),
      ],
    );
  }

  Widget _buildContent(
    InspectionState state,
    InspectionController controller,
  ) =>
      InspectionContent(
        createdAt: state.createdAt,
        heartRate: state.heartRate,
        isFine: state.isFine == true,
        hasMurmur: state.hasMurmur == true,
        organ: state.organ,
        onTap: controller.openReport,
      );

  double _getBottomPadding(MediaQueryData mediaQuery) =>
      mediaQuery.padding.bottom == 0
          ? aboveLowestIndent
          : mediaQuery.padding.bottom;

  /// Builds the header of the existing record widget.
  Widget _buildHeader(
    InspectionState state,
    InspectionController controller,
  ) =>
      InspectionHeader(
        spot: state.spot,
        recordId: recordId,
        name: state.name,
        mutable: mutable,
        onDelete: controller.delete,
        onRecordAgain: controller.recordAgain,
      );

  /// Builds the play button for the existing record widget.
  Widget _buildPlayButton(InspectionController controller, ThemeData theme) {
    final buttonColor = theme.colorScheme.secondary;
    final backgroundColor = theme.colorScheme.primaryContainer;
    final styleFrom = ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      fixedSize: _buttonSize,
      backgroundColor: buttonColor,
      elevation: 0,
      shape: _buttonShape,
    );
    final icon = Icon(
      AppIcons.play,
      color: backgroundColor,
      size: middleIndent,
      semanticLabel: _playButtonLabel,
    );
    return ElevatedButton(
      key: _playButtonKey,
      onPressed: controller.play,
      style: styleFrom,
      child: icon,
    );
  }
}

const _borderRadius = BorderRadius.only(
  topLeft: Radius.circular(middleIndent),
  topRight: Radius.circular(middleIndent),
);
const _buttonSize = Size(56, 56);
const _buttonShape = CircleBorder();

/// Semantic labels
const _playButtonLabel = 'play_button_label';

/// Keys
const _playButtonKey = Key('play_button_key');
