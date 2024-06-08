import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../examination.dart';
import '../../providers.dart';
import 'inspection/inspection.dart';
import 'new_record/new_record.dart';

class RecordBottom extends ConsumerWidget {
  static const screenHeightQuotient = 0.35;
  static const minVisualizationHeightQuotient = 0.35;
  static const maxVisualizationHeightQuotient = 0.7;

  const RecordBottom({
    super.key,
    required this.examination,
    this.mutable = true,
  });

  final Examination examination;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordState = ref.watch(examinationStateProvider);

    final currentPoint = examination.examinationPoints.singleWhere(
      (rp) => rp.point.spot == recordState.currentSpot,
    );
    final recordPoint = currentPoint.point;
    final records = currentPoint.records;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final visualizationHeight =
        screenHeight * RecordBottom.screenHeightQuotient;

    return Positioned(
      bottom: 0,
      width: screenWidth,
      child: Column(
        children: [
          const SizedBox(height: 16),
          if (records.isNotEmpty)
            Inspection(
              recordId: records.first.id!,
              mutable: mutable,
              bodyPosition: records.first.bodyPosition,
            )
          else
            NewRecord(
              height: visualizationHeight,
              recordPoint: recordPoint,
              enabled: mutable,
            ),
        ],
      ),
    );
  }
}
