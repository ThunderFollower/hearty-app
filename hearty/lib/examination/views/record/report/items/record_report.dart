import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../config.dart';
import '../../../../../core/routes/constants.dart';
import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../segments/segment_types.dart';
import '../../../examination_report/items/disclaimer/disclaimer.dart';
import '../controller/providers.dart';
import '../controller/record_report_controller.dart';

part 'common/record_report_diagram_gesture_detector.dart';
part 'common/record_report_expanded_diagram.dart';
part 'common/record_report_insufficient_quality_pattern.dart';
part 'common/record_report_tile_container.dart';
part 'cycle_diagram/record_report_cycle_diagram.dart';
part 'cycle_diagram/record_report_cycle_diagram_content.dart';
part 'cycle_diagram/record_report_cycle_diagram_cycle_number.dart';
part 'cycle_diagram/record_report_cycle_diagram_legend.dart';
part 'cycle_diagram/record_report_cycle_diagram_time_ruler.dart';
part 'findings/record_report_findings.dart';
part 'heart_rate/record_report_heart_rate.dart';
part 'heart_rate/record_report_heart_rate_content.dart';
part 'quality/record_report_quality.dart';
part 'quality/record_report_quality_bar.dart';
part 'quality/record_report_quality_header.dart';
part 'record_report_title_bar.dart';
part 'segment_diagram/record_report_segment_diagram.dart';
part 'segment_diagram/record_report_segment_diagram_content.dart';
part 'segment_diagram/record_report_segment_diagram_legend.dart';
part 'segment_diagram/record_report_segment_diagram_segment.dart';
part 'segment_diagram/record_report_segment_diagram_time_ruler_with_legend.dart';
part 'skeleton/record_report_skeleton.dart';
part 'skeleton/record_report_skeleton_tile.dart';

@RoutePage()
class RecordReportPage extends ConsumerWidget {
  const RecordReportPage(
    @PathParam(recordIdParam) this.recordId, {
    @QueryParam(spotNumberParam) this.spotNumber = 0,
    @QueryParam(spotNameParam) this.spotName = '',
    @QueryParam(bodyPositionParam) this.bodyPosition = '',
  });

  final String? recordId;
  final int spotNumber;
  final String spotName;
  final String bodyPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = recordReportStateProvider(recordId!);
    final hasData = ref.watch(provider.select((state) => state.hasData));
    final heartRate = ref.watch(provider.select((state) => state.heartRate));
    final hasMurmur = ref.watch(provider.select((state) => state.hasMurmur));
    final controller = ref.watch(provider.notifier);
    final qualityList = controller.buildQualityList();
    final qualityPercent = controller.computeQualityPercentage();
    final segmentList = controller.buildSegmentList();
    final cycleList = controller.buildCycleList();

    _SegmentDiagram segmentDiagramProvider({required bool verticalLayout}) =>
        _SegmentDiagram(
          segments: segmentList,
          verticalLayout: verticalLayout,
        );
    _CycleDiagram cycleDiagramProvider({required bool verticalLayout}) =>
        _CycleDiagram(
          cycles: cycleList,
          verticalLayout: verticalLayout,
        );

    final reportData = Column(
      children: [
        _Findings(
          hasMurmur: hasMurmur,
          onTap: controller.openVisualization,
        ),
        const SizedBox(height: lowestIndent),
        _Quality(
          qualityList: qualityList,
          qualityPercent: qualityPercent,
        ),
        const SizedBox(height: lowestIndent),
        _HeartRate(heartRate: heartRate),
        const SizedBox(height: lowestIndent),
        _DiagramGestureDetector(
          title: LocaleKeys.RecordReport_Sequence_of_heart_cycles.tr(),
          diagramProvider: segmentDiagramProvider,
        ),
        const SizedBox(height: lowestIndent),
        _DiagramGestureDetector(
          title: LocaleKeys.RecordReport_Duration_of_systole.tr(),
          diagramProvider: cycleDiagramProvider,
        ),
      ],
    );
    final content = hasData ? reportData : const RecordReportSkeleton();
    final column = Column(
      children: [
        content,
        const SizedBox(height: lowestIndent),
        Disclaimer(onOpenGuide: controller.openGuide),
        const SizedBox(height: highIndent),
      ],
    );
    return AppScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
        child: column,
      ),
      appBar: _titleBar(
        spotNumber: spotNumber,
        spotName: spotName,
        bodyPosition: bodyPosition,
        context: context,
      ),
    );
  }
}

const _neutralAttentionIconPath = 'assets/images/neutral_attention.svg';
const _redAttentionIconPath = 'assets/images/red_attention.svg';
const _heartRateIconPath = 'assets/images/heart_rate.svg';
const _insufficientQualityBackgroundPath =
    'assets/images/insufficient_quality.svg';
const double _qualityBarHeight = 15.0;

const _segmentHeightVerticalLayout = 70.0;
const _segmentHeightDividerHorizontalLayout = 3.3;
const _segmentDefaultWidthVerticalLayout = 1.3;
const _segmentDefaultWidthHorizontalLayout = 3.0;
const _insufficientQualityHeightQuotient = 0.96;
const _insufficientQualityPatternWidth = 200.0;

const double _cycleDefaultWidth = 20.0;
const int _cycleDiagramTimeRulerRowNumber = 5;
const double _cycleNumberHeight = 15.0;
const _cycleDiagramVerticalLayoutHeight = 100.0;
const _cycleDiagramHeightDividerHorizontalLayout = 2.3;
const _cycleDiagramVerticalLayoutSideBarWidth = 20.0;
const _cycleDiagramHorizontalLayoutSideBarWidth = 40.0;

final double _duration = Config.signalDuration.inSeconds.toDouble();
