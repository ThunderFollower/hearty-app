import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../auth/auth.dart';
import '../../../core/core.dart';
import '../../../core/views.dart';
import '../../examination.dart';
import '../connection/config/connection_controller_provider.dart';
import '../record/playback_controls/filters_extension.dart';
import 'stethoscope_controller.dart';

final stethoscopeStateProvider =
    StateNotifierProvider.autoDispose<StethoscopeController, StethoscopeState>(
  (ref) {
    final state = StethoscopeState(
      isAudioEngineOn: const AsyncValue.loading(),
      recordingState: RecordingState(),
      filterGain: {
        Filters.bell: Filters.bell.defaultGain,
        Filters.diaphragm: Filters.diaphragm.defaultGain,
        Filters.starling: Filters.starling.defaultGain,
      },
    );

    return StethoscopeController(
      state,
      ref.watch(permissionService(Permission.microphone)),
      ref,
      ref.watch(saveRecordProvider),
      ref.watch(determineRecordAnalysisProvider),
      Logger(),
      ref.watch(routerProvider),
      audioEngine: ref.watch(audioEngineProvider),
      declicker: ref.read(declickerSettingProvider),
      ref.watch(navigatorKeyProvider),
      ref.watch(authProfileServiceProvider),
    );
  },
);

final stethoscopeModeProvider =
    StateProvider<StethoscopeMode>((ref) => StethoscopeMode.listening);

final stethoscopeIsOpenProvider = StateProvider<bool>((ref) => false);

final connectionOpenProvider = Provider<bool>(
  (ref) {
    final provider = connectionControllerProvider.select(
      (value) => value.isConnected,
    );
    return ref.watch(provider);
  },
);
