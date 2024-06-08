import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../examination.dart';
import 'constants.dart';
import 'segmentation_panel_common_label.dart';
import 'segmentation_panel_pathologic_label.dart';

class SegmentationPanelLabel extends StatelessWidget {
  const SegmentationPanelLabel({
    super.key,
    required this.label,
    required this.start,
    required this.end,
    required this.type,
  });

  final String label;
  final double start;
  final double end;
  final SegmentTypes type;

  @override
  Widget build(BuildContext context) => Positioned(
        left: start,
        height: segmentationPanelHeight,
        child: _buildLabel(context),
      );

  Widget _buildLabel(BuildContext context) {
    switch (type) {
      case SegmentTypes.s3:
        return SegmentationPanelPathologicLabel(
          label: label,
          color: Theme.of(context).colorScheme.onErrorContainer,
          start: start,
          end: end,
        );
      case SegmentTypes.s4:
        return SegmentationPanelPathologicLabel(
          label: label,
          color: Theme.of(context).colorScheme.onSecondary,
          start: start,
          end: end,
        );
      default:
        return SegmentationPanelCommonLabel(
          label: label,
          gradient: _gradient[type],
          start: start,
          end: end,
        );
    }
  }
}

final _gradient = {
  SegmentTypes.s1: AppGradients.cyan2,
  SegmentTypes.s2: AppGradients.orange,
  SegmentTypes.unsegmentable: AppGradients.whiteStriped,
};
