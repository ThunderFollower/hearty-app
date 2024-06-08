import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import '../../../../core/views/theme/indentation_constants.dart';
import '../../../examination.dart';
import '../../examination/providers.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';
import 'filter_button/filter_button.dart';
import 'record_button/doctor_record_button.dart';
import 'record_button/patient_record_button.dart';

class StethoscopeSheetButtons extends ConsumerWidget {
  const StethoscopeSheetButtons({
    super.key,
    this.recordId,
    this.padding = EdgeInsets.zero,
  });

  final String? recordId;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(stethoscopeModeProvider);
    final isRecordingMode = mode == StethoscopeMode.recording;
    final recordingState = ref.watch(
      stethoscopeStateProvider.select((value) => value.recordingState.state),
    );
    final isRecordingReady = recordingState == RecordingStates.ready;
    final isDoctorMode = ref.watch(
      stethoscopeStateProvider.select((value) => value.isDoctorMode),
    );

    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _buildButtons(
          isRecordingMode,
          isDoctorMode,
          isRecordingReady,
        ),
      ),
    );
  }

  List<Widget> _buildButtons(
    bool isRecordingMode,
    bool? isDoctorMode,
    bool isRecordingReady,
  ) {
    if (isDoctorMode == null) return List.empty();
    if (!isRecordingMode) return _filterButtons;

    return [
      if (isRecordingReady && isDoctorMode) ...[
        ..._filterButtons,
        const SizedBox(width: aboveLowestIndent),
      ],
      _RecordButton(
        recordId: recordId,
        isDoctorMode: isDoctorMode,
        isRecordingReady: isRecordingReady,
      ),
    ];
  }

  List<Widget> get _filterButtons => [
        const FilterButton(
          filter: Filters.starling,
          nameId: 'starling_filter_btn',
          internalKey: Key('starling_filter_btn'),
        ),
        const FilterButton(
          filter: Filters.diaphragm,
          nameId: 'diagram_filter_btn',
          internalKey: Key('diagram_filter_btn'),
        ),
        const FilterButton(
          filter: Filters.bell,
          nameId: 'bell_filter_btn',
          internalKey: Key('bell_filter_btn'),
        ),
      ];
}

class _RecordButton extends ConsumerWidget {
  const _RecordButton({
    this.recordId,
    required this.isDoctorMode,
    required this.isRecordingReady,
  });

  final String? recordId;
  final bool isDoctorMode;
  final bool isRecordingReady;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(stethoscopeStateProvider.notifier);
    final spot = ref.watch(
      examinationStateProvider.select((value) => value.currentSpot),
    );

    if (isDoctorMode && isRecordingReady) {
      final button = DoctorRecordButton(
        nameId: 'doctor_start_record_btn',
        key: const Key('doctor_start_record'),
        totalTime: Config.signalDuration.inSeconds,
        onPressed: () => controller.record(recordId: recordId, spot: spot),
      );
      return Container(margin: _buttonMargin, child: button);
    }

    return PatientRecordButton(
      nameId: 'patient_start_record_btn',
      key: const Key('patient_start_record'),
      totalTime: Config.signalDuration.inSeconds,
      onPressed: () => controller.record(recordId: recordId, spot: spot),
    );
  }
}

const _buttonMargin = EdgeInsets.only(bottom: belowLowIndent);
