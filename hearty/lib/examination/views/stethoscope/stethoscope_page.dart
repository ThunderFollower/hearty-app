import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/core.dart';
import '../../../core/views.dart';
import 'body/stethoscope_body.dart';
import 'press/press.dart';
import 'providers.dart';
import 'stethoscope_controller.dart';
import 'stethoscope_sheet_buttons/stethoscope_sheet_buttons.dart';
import 'title/stethophone_sheet_title.dart';

@RoutePage()
class StethoscopePage extends ConsumerStatefulWidget {
  const StethoscopePage({
    super.key,
    @QueryParam(recordIdParam) this.recordId,
  });

  final String? recordId;

  @override
  ConsumerState<StethoscopePage> createState() => _StethoscopePageState();
}

class _StethoscopePageState extends ConsumerState<StethoscopePage> {
  late StethoscopeController controller;

  @override
  void dispose() {
    controller.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = stethoscopeStateProvider;
    controller = ref.watch(provider.notifier);
    final isAudioEngineOn = ref.watch(
      provider.select((value) => value.isAudioEngineOn),
    );
    final isMicEnabled = ref.watch(
      provider.select((value) => value.isMicrophoneEnabled ?? true),
    );
    final recordingState = ref.watch(
      provider.select((value) => value.recordingState.state),
    );

    final height = MediaQuery.of(context).size.height;

    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAppBar(controller, recordingState),
        const SizedBox(height: highIndent),
        if (isMicEnabled) _buildRecordButton(isAudioEngineOn),
        StethoscopeBody(isAudioEngineOn: isAudioEngineOn),
        SizedBox(height: height * _paddingQuotient),
        if (_isClosingAvailable(recordingState)) _buildFooter(),
      ],
    );
    return Scaffold(body: SafeArea(child: content));
  }

  Widget _buildRecordButton(AsyncValue<String> isAudioEngineOn) =>
      isAudioEngineOn.maybeWhen(
        data: (_) => StethoscopeSheetButtons(
          recordId: widget.recordId,
          padding: _padding,
        ),
        orElse: () => const SizedBox.shrink(),
      );

  Widget _buildAppBar(
    StethoscopeController controller,
    RecordingStates recordingState,
  ) {
    final icon = Icon(
      AppIcons.close,
      color: _closeButtonColor(recordingState),
    );
    final iconButton = IconButton(
      alignment: Alignment.centerLeft,
      onPressed: controller.close,
      icon: icon,
    );

    final row = Row(
      children: [
        iconButton,
        const StethoscopeSheetTitle(),
        const SizedBox(width: extremelyHightIndent),
      ],
    );

    return Padding(padding: _padding, child: row);
  }

  Widget _buildFooter() => const Press();

  bool _isClosingAvailable(RecordingStates recordingState) =>
      recordingState == RecordingStates.ready ||
      recordingState == RecordingStates.recording;

  Color _closeButtonColor(RecordingStates recordingState) {
    switch (recordingState) {
      case RecordingStates.saving:
      case RecordingStates.checkingQuality:
        return AppColors.grey.withOpacity(_closeButtonDisabledOpacity);
      default:
        return AppColors.grey;
    }
  }
}

const _padding = EdgeInsets.symmetric(horizontal: lowIndent);

// Padding between the human body and the `Press to body` text.
// It's the ratio of the indentation to the screen height as per design.
const _paddingQuotient = 0.09;

// Opacity for close button icon for some 'inactive' states
const _closeButtonDisabledOpacity = 0.5;
