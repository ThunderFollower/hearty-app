import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/common.dart';
import '../segment/segment.dart';
import 'constants.dart';
import 'segmentation_panel_label.dart';

part 'segmentation_panel_background.dart';
part 'segmentation_panel_content.dart';
part 'segmentation_panel_state.dart';

class SegmentationPanel extends ConsumerStatefulWidget {
  const SegmentationPanel({
    super.key,
    required this.width,
    required this.recordId,
    required this.padding,
    required this.margin,
    this.segments,
  });

  /// Widget width.
  final double width;

  /// Identifier for the associated audio record.
  final String recordId;

  final double padding;
  final EdgeInsetsGeometry margin;
  final Iterable<SegmentState>? segments;

  @override
  ConsumerState<SegmentationPanel> createState() => _SegmentationPanelState();
}
