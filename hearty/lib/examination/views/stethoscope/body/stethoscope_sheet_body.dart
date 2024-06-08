import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../examination.dart';
import '../gain_control/gain_control.dart';
import '../oscillogram/oscillogram_view.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';
import 'human_body/stethoscope_sheet_human_body.dart';

const _bodySizeQuotient = 0.75;

class StethoscopeSheetBody extends ConsumerWidget {
  const StethoscopeSheetBody({
    super.key,
    required this.isAudioEngineOn,
    required this.width,
    required this.height,
  });

  final AsyncValue<String> isAudioEngineOn;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodySize = Size(width * _bodySizeQuotient, height);
    final isRecording =
        ref.watch(stethoscopeModeProvider) == StethoscopeMode.recording;
    final isReady = ref.watch(
      stethoscopeStateProvider.select(
        (value) => value.recordingState.state == RecordingStates.ready,
      ),
    );
    final showBody = isRecording && isReady;
    final theme = Theme.of(context);
    final errorTextStyle = theme.textTheme.headlineLarge?.copyWith(
      color: theme.colorScheme.error,
    );
    return Expanded(
      child: Stack(
        children: [
          isAudioEngineOn.map(
            data: (_) => Column(
              children: [
                const OscillogramView(),
                if (showBody)
                  StethoscopeSheetHumanBody(sizeRestrictions: bodySize),
              ],
            ),
            loading: (_) => const Loader(),
            error: (message) => Center(
              child: Text(
                message.error as String,
                style: errorTextStyle,
              ),
            ),
          ),
          const GainControl(),
        ],
      ),
    );
  }
}
