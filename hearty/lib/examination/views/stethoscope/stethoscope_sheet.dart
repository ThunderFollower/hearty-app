import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import 'body/stethoscope_sheet_body.dart';
import 'press/press.dart';
import 'providers.dart';
import 'stethoscope_controller.dart';
import 'stethoscope_sheet_buttons/stethoscope_sheet_buttons.dart';
import 'title/stethophone_sheet_title.dart';

class StethoscopeSheet extends ConsumerStatefulWidget {
  const StethoscopeSheet({super.key, this.recordId});

  final String? recordId;

  @override
  ConsumerState<StethoscopeSheet> createState() => _StethoscopeSheetState();
}

class _StethoscopeSheetState extends ConsumerState<StethoscopeSheet> {
  static const horizontalPadding = 20.0;
  late StethoscopeController? controller;

  @override
  Widget build(BuildContext context) {
    final provider = stethoscopeStateProvider;
    controller = ref.watch(provider.notifier);
    final isAudioEngineOn = ref.watch(
      provider.select((value) => value.isAudioEngineOn),
    );
    final isSaving = ref.watch(
      provider.select(
        (value) => value.recordingState.state == RecordingStates.saving,
      ),
    );
    final isMicEnabled = ref.watch(
      provider.select((value) => value.isMicrophoneEnabled ?? true),
    );

    final height = MediaQuery.of(context).size.height * 0.95;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onVerticalDragStart: isSaving ? (_) {} : null,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
          height: height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                ),
                child: Row(
                  children: [
                    IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: isSaving ? null : context.popRoute,
                      icon: const AppLocator(
                        id: 'close_button',
                        child: Icon(AppIcons.close),
                      ),
                    ),
                    const StethoscopeSheetTitle(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (isMicEnabled)
                isAudioEngineOn.map(
                  data: (_) => StethoscopeSheetButtons(
                    recordId: widget.recordId,
                    padding: const EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                    ),
                  ),
                  error: (_) => const SizedBox.shrink(),
                  loading: (_) => const SizedBox.shrink(),
                ),
              StethoscopeSheetBody(
                isAudioEngineOn: isAudioEngineOn,
                width: width,
                height: height,
              ),
              const SizedBox(height: belowMediumIndent),
              const Press(),
            ],
          ),
        ),
      ),
    );
  }
}
