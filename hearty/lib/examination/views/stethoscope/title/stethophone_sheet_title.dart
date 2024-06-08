import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../examination.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';

class StethoscopeSheetTitle extends ConsumerWidget {
  const StethoscopeSheetTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording =
        ref.watch(stethoscopeModeProvider) == StethoscopeMode.recording;
    final selectRecordingState = stethoscopeStateProvider.select(
      (value) => value.recordingState.state,
    );
    final recordingState = ref.watch(selectRecordingState);

    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge;

    return _buildText(isRecording, recordingState, textStyle);
  }

  Widget _buildText(
    bool isRecording,
    RecordingStates recordingState,
    TextStyle? textStyle,
  ) {
    final title = _getTitle(isRecording, recordingState);
    final text = Text(title, textAlign: TextAlign.center, style: textStyle);
    final fittedBox = FittedBox(fit: BoxFit.scaleDown, child: text);

    return Expanded(child: fittedBox);
  }

  String _getTitle(
    bool isRecording,
    RecordingStates recordingState,
  ) {
    if (!isRecording) return LocaleKeys.Stethoscope.tr();

    return _titleTextMap[recordingState]!.tr();
  }

  Map<RecordingStates, String> get _titleTextMap => {
        RecordingStates.recording: LocaleKeys.Recording_in_Progress,
        RecordingStates.saving: LocaleKeys.Saving,
        RecordingStates.checkingQuality: LocaleKeys.Analyzing_Results,
        RecordingStates.ready: LocaleKeys.Start_Recording,
        RecordingStates.finished: LocaleKeys.Start_Recording,
      };
}
