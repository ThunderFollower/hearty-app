import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views/button/round_filled_button/round_filled_button.dart';
import '../../../../../core/views/theme/app_gradients.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../providers.dart';
import '../../stethoscope_controller.dart';
import 'countdown/countdown_arch.dart';
import 'record_loader.dart';

class PatientRecordButton extends ConsumerWidget {
  const PatientRecordButton({
    super.key,
    required this.totalTime,
    this.onPressed,
    this.nameId = 'patient_record_btn',
  });

  final VoidCallback? onPressed;
  final int totalTime;
  final String nameId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recording = ref.watch(
      stethoscopeStateProvider.select((value) => value.recordingState),
    );

    final theme = Theme.of(context);

    const loader = RecordLoader(size: _size, strokeWidth: _strokeWidth);
    final countdownArch = CountdownArch(
      strokeWidth: _strokeWidth,
      size: _size,
      totalTime: totalTime,
      timeLeft: recording.timeLeft,
    );

    final button = _buildRecordButton(recording, theme);

    final stack = Stack(
      alignment: Alignment.center,
      children: [
        if (recording.state == RecordingStates.saving ||
            recording.state == RecordingStates.checkingQuality)
          loader
        else
          countdownArch,
        button,
      ],
    );

    return RepaintBoundary(child: stack);
  }

  DecoratedBox _buildRecordButton(RecordingState recording, ThemeData theme) {
    final textColor = theme.colorScheme.onSecondary;
    final textStyle = theme.textTheme.labelLarge?.copyWith(color: textColor);

    final text = Text(_takeTextInfo(recording), style: textStyle);
    final roundFilledButton = RoundFilledButton(
      size: _filledButtonSize,
      id: nameId,
      onPressed: recording.state == RecordingStates.ready ? onPressed : null,
      color: Colors.transparent,
      child: text,
    );

    return DecoratedBox(decoration: _boxDecoration, child: roundFilledButton);
  }

  String _takeTextInfo(RecordingState recording) {
    switch (recording.state) {
      case RecordingStates.ready:
        return LocaleKeys.Start.tr();
      case RecordingStates.recording:
        return recording.timeLeft.toString();
      default:
        return '';
    }
  }
}

const _size = 102.0;
const _strokeWidth = 2.0;
const _filledButtonSize = 88.0;
const _boxDecoration = BoxDecoration(
  shape: BoxShape.circle,
  gradient: AppGradients.red,
);
