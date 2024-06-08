import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../gain_control/gain_control.dart';
import '../oscillogram/oscillogram_view.dart';
import '../providers.dart';
import '../stethoscope_controller.dart';
import 'human_body/stethoscope_sheet_human_body.dart';

class StethoscopeBody extends ConsumerWidget {
  const StethoscopeBody({
    super.key,
    required this.isAudioEngineOn,
  });

  final AsyncValue<String> isAudioEngineOn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(
      stethoscopeStateProvider.select(
        (value) => value.recordingState.state,
      ),
    );

    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final content = _buildContent(recordingState, theme, size);
    final stack = Stack(children: [content, const GainControl()]);
    return Expanded(child: stack);
  }

  Widget _buildContent(RecordingStates state, ThemeData theme, Size size) =>
      isAudioEngineOn.map(
        data: (_) => _buildBody(state, theme, size),
        loading: (_) => const Loader(),
        error: (message) => Center(child: _buildError(message, theme)),
      );

  Widget _buildBody(RecordingStates state, ThemeData theme, Size size) =>
      // Column is required to avoid rendering issues.
      Column(
        children: [
          switch (state) {
            RecordingStates.ready => _buildBodyWithOscillogram(size),
            RecordingStates.recording => const OscillogramView(),
            _ => const SizedBox.shrink()
          },
        ],
      );

  Widget _buildBodyWithOscillogram(Size size) => const Expanded(
        child: Column(
          children: [OscillogramView()],
        ),
      );

  Widget _buildError(AsyncError<String> message, ThemeData theme) {
    final errorTextStyle = theme.textTheme.headlineLarge?.copyWith(
      color: theme.colorScheme.error,
    );
    return Text(message.error as String, style: errorTextStyle);
  }

  Widget _buildHumanBody(Size size) {
    final height = size.height;
    final bodySize = Size(size.width * _bodySizeQuotient, height);

    return StethoscopeSheetHumanBody(sizeRestrictions: bodySize);
  }
}

const _bodySizeQuotient = 0.75;
