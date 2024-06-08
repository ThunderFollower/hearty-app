import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:async/async.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app_router.gr.dart';
import '../../../auth/account/auth_profile_service.dart';
import '../../../auth/account/user_role.dart';
import '../../../config.dart';
import '../../../core/core.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/utils.dart';
import '../../examination.dart';
import '../../record/record_analysis_status.dart';
import '../../views/examination_root/examination_list_controller.dart';
import '../examination/index.dart';
import '../menu/settings/show_settings_dialog.dart';
import '../record/playback_controls/filters_extension.dart';
import 'detail/show_bt_settings_dialog.dart';
import 'providers.dart';

class StethoscopeController extends StateNotifier<StethoscopeState>
    with SubscriptionManager {
  StethoscopeController(
    super.state,
    this._permissionService,
    this._ref,
    this._saveRecordUseCase,
    this._determineRecordAnalysis,
    this._logger,
    this._router,
    this._key,
    this._authProfileService, {
    required this.audioEngine,
    required bool declicker,
  }) : isDeclickerEnabled = declicker {
    _permissionService
      ..grant()
      ..observeStatusChanges()
          .where(_isPermissionGrantingRequired)
          .listen(_handlePermission)
          .addToList(this);
    _authProfileService
        .observeProfileChanges()
        .map((event) => event?.role)
        .distinct()
        .listen(_handleRole)
        .addToList(this);
    _refreshTimer = Timer.periodic(fetchInterval, _refreshOscillogram);
    _initAudioEngine();
  }

  @protected
  final AudioEngine audioEngine;

  final bool isDeclickerEnabled;

  final Logger _logger;

  final SaveRecordUseCase _saveRecordUseCase;

  final DetermineRecordAnalysisUseCase _determineRecordAnalysis;
  final StackRouter _router;

  /// The [GlobalKey] used to access the application's navigation context.
  final GlobalKey _key;
  final PermissionService _permissionService;

  final AuthProfileService _authProfileService;

  static const eventChannel = EventChannel('sparrowacoustics.com/eventStream');
  static const dataWindow = 60;
  static const fetchInterval = Duration(milliseconds: 50);
  final Ref _ref;
  StreamSubscription? _audioEventSubscription;
  StreamSubscription? _engineEventSubscription;
  List<double> signal = [];
  late final Timer _refreshTimer;
  Timer? _gainControlTimer;
  int _lastIndex = 0;
  bool _isCancelled = false;
  bool? _isBtHeadphonesConnected;
  double _dragStartPoint = 0;
  double _dragDelta = 0;
  ProviderSubscription? _subscription;
  bool isBtSettingsDialogOpen = false;

  /// The length of an oscillogram sample.
  static const sampleLength = int.fromEnvironment(
    'SAMPLE_LENGTH',
    defaultValue: 1000,
  );

  bool get _isFinalPhase =>
      state.recordingState.state == RecordingStates.saving ||
      state.recordingState.state == RecordingStates.checkingQuality ||
      state.recordingState.state == RecordingStates.finished;

  bool get _isNotFinalPhase => _isFinalPhase == false;

  @override
  void dispose() {
    _cancel();
    unawaited(audioEngine.close());
    _ref.read(stethoscopeIsOpenProvider.notifier).state = false;
    _subscription?.close();
    cancelSubscriptions();
    super.dispose();
  }

  void _cancel() {
    _refreshTimer.cancel();
    _audioEventSubscription?.cancel();
    _engineEventSubscription?.cancel();
    _gainControlTimer?.cancel();
  }

  void _handlePermission(PermissionStatus status) {
    state = state.copyWith(microphoneDisabled: false);
    final context = _key.currentContext;
    assert(context != null);
    if (context == null) return;
    showSettingsDialog(
      context: context,
      title: LocaleKeys.Enable_Microphone_Access.tr(),
      body: LocaleKeys
              .This_allows_you_to_record_heart_and_lungs_sounds_and_listen_in_real_time
          .tr(),
      iconPath: _micPermissionIconPath,
      onTap: openAppSettings,
    );
  }

  bool _isPermissionGrantingRequired(PermissionStatus status) =>
      status != PermissionStatus.granted;

  void _handleRole(UserRole? event) {
    state = state.copyWith(isDoctorMode: event == UserRole.doctor);
  }

  Filters _configureDefaultFilter() {
    Filters defaultFilter = Config.defaultHeartFilter;
    final isRecordingMode =
        _ref.read(stethoscopeModeProvider) == StethoscopeMode.recording;
    if (isRecordingMode) {
      final organType = _ref.read(examinationStateProvider).organType;
      defaultFilter = organType == OrganType.heart
          ? defaultFilter
          : Config.defaultLungsFilter;
    }
    return defaultFilter;
  }

  Future<void> _initAudioEngine() async {
    final Filters defaultFilter = _configureDefaultFilter();

    state = state.copyWith(
      activeFilter: defaultFilter,
      gain: defaultFilter.defaultGain,
    );

    final res = await audioEngine.setup(
      mode: defaultFilter.effect,
      gain: defaultFilter.defaultGain,
      declicker: isDeclickerEnabled,
    );

    if (mounted) {
      state = state.copyWith(
        isAudioEngineOn: res == Config.audioEngineIsOnResponse
            ? AsyncValue.data(res!)
            : AsyncValue.error(
                LocaleKeys.Audio_Engine_error.tr(),
                StackTrace.current,
              ),
      );
    }

    _subscription = _ref.listen<bool>(connectionOpenProvider, (_, isConnected) {
      if (!isConnected && mounted) {
        cancel();
        state = state.copyWith(recordingState: RecordingState(timeLeft: 0));
      }
    });

    final stream = StethoscopeController.eventChannel.receiveBroadcastStream();
    final skipStream = stream.skipWhile(
      (event) => ((event ?? []) as Map<Object?, Object?>)['isEngineOn'] != true,
    );
    _audioEventSubscription = skipStream.listen(_onEvent, onError: (_, __) {});
  }

  void cancel() => _isCancelled = true;

  void showGain() {
    _gainControlTimer?.cancel();
    state = state.copyWith(gainOpacity: 1);
    _gainControlTimer = Timer(Config.gainControlVisibilityDuration, () {
      _gainControlTimer?.cancel();
      state = state.copyWith(gainOpacity: 0);
    });
  }

  void _refreshOscillogram(Timer _) {
    int index = this.signal.length;
    if (this.signal.length - _lastIndex > dataWindow) {
      index = _lastIndex + dataWindow;
    }
    final signal = [
      ...state.signal,
      ...this.signal.sublist(_lastIndex, index),
    ];
    if (signal.length > sampleLength) {
      signal.removeRange(0, signal.length - sampleLength);
    }

    state = state.copyWith(signal: signal);
    _lastIndex = index;
  }

  void _onEvent(Object? event) {
    final data = (event ?? []) as Map<Object?, Object?>;
    _handleAudioDataUpdate(data);
    _handleEngineStateChange(data);
    _handleBtHeadphonesConnectionChange(data);
  }

  void _handleAudioDataUpdate(Map<Object?, Object?> data) {
    final audioData = ((data['audioData'] ?? []) as List<Object?>)
        .map((e) => (e ?? 0) as double)
        .toList();
    signal.addAll(audioData);
  }

  void _handleBtHeadphonesConnectionChange(Map<Object?, Object?> data) {
    if (_isCancelled || _isFinalPhase) return;
    final isHeadphonesConnected = data['isBtHeadphonesConnected'] == true;
    if ((_isBtHeadphonesConnected == null ||
            _isBtHeadphonesConnected == true) &&
        isHeadphonesConnected == false) {
      _isBtHeadphonesConnected = false;
      final mode = _ref.read(stethoscopeModeProvider);
      final bodyText = mode == StethoscopeMode.recording
          ? LocaleKeys.You_can_also_record_without_listening.tr()
          : '';
      isBtSettingsDialogOpen = true;
      showBtSettingsDialog(
        context: _router.navigatorKey.currentState!.context,
        title: LocaleKeys.To_listen_connect_Bluetooth_headphones.tr(),
        body: bodyText,
        buttonText: LocaleKeys.Open_Bluetooth_Settings.tr(),
        onTap: () {
          _router.pop();
          AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
        },
      ).then((value) => isBtSettingsDialogOpen = false);
    } else if (isBtSettingsDialogOpen &&
        isHeadphonesConnected == true &&
        _isBtHeadphonesConnected == false) {
      _isBtHeadphonesConnected = true;
      _router.pop();
    }
  }

  void setActiveFilter(Filters filter) {
    final gain = state.filterGain[filter];
    if (gain != null) {
      audioEngine.gain = gain;
    }

    audioEngine.mode = filter.effect;
    state = state.copyWith(activeFilter: filter, gain: gain);
    showGain();
  }

  void setGain(int gain) {
    int normalizedGain = gain;

    normalizedGain = min(
      state.activeFilter.maxGain,
      max(state.activeFilter.minGain, gain),
    );

    if (normalizedGain == state.gain) {
      showGain();
      return;
    }

    audioEngine.gain = normalizedGain;

    final gainMap = state.filterGain;
    gainMap[state.activeFilter] = normalizedGain;
    state = state.copyWith(filterGain: {...gainMap}, gain: normalizedGain);
    showGain();
  }

  Future<void> record({String? recordId, required Spot spot}) async {
    state = state.copyWith(
      recordingState: RecordingState(state: RecordingStates.recording),
    );

    await audioEngine.startRecording();
    Examination exam = _ref.read(examinationStateProvider).examination.value!;
    _isCancelled = false;

    final cancelable = CancelableOperation.fromFuture(
      Future.delayed(Config.signalDuration, () => false),
    );

    final countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isCancelled) {
        cancelable.cancel();
        return;
      }
      state = state.copyWith(
        recordingState: RecordingState(
          state: state.recordingState.state,
          timeLeft: state.recordingState.timeLeft - 1,
        ),
      );
    });

    final wasCancelled = await cancelable.valueOrCancellation(true);
    countdownTimer.cancel();

    if (wasCancelled == true) return;

    final filePath = await audioEngine.finishRecording() ?? '';

    state = state.copyWith(
      recordingState:
          RecordingState(state: RecordingStates.saving, timeLeft: 0),
    );

    final isOpen = _ref.read(stethoscopeIsOpenProvider);
    if (_isCancelled || filePath.isEmpty && isOpen) {
      _ref.read(stethoscopeModeProvider.notifier).state =
          StethoscopeMode.listening;
      return;
    }

    await audioEngine.close();
    vibrate();
    final file = File(filePath);

    final examinationController = _ref.read(
      examinationStateProvider.notifier,
    );

    ExaminationPoint currentPoint =
        exam.examinationPoints.singleWhere((rp) => rp.point.spot == spot);
    final bodyPosition = _ref.read(examinationStateProvider).bodyPosition;
    final isNewExam = exam.isNew;
    if (isNewExam) {
      exam = await _ref.read(examinationListController.notifier).save(exam);
      await examinationController.init(id: exam.id!);
      exam = _ref.read(examinationStateProvider).examination.value!;
      currentPoint =
          exam.examinationPoints.singleWhere((rp) => rp.point.spot == spot);
    } else {
      final examinationCopy = exam.copyWith(modifiedAt: DateTime.now());
      exam = await _ref
          .read(examinationListController.notifier)
          .save(examinationCopy);
    }
    // [RecordAnalysisStatus.none] for the rerecording.
    final analysisStatus = recordId != null ? RecordAnalysisStatus.none : null;
    final record = await save(
      currentPoint,
      file,
      bodyPosition,
      recordId,
      analysisStatus,
    );

    await file.delete();

    if (isNewExam &&
        currentPoint.point.type !=
            _ref.read(examinationStateProvider).organType) {
      _ref.read(examinationStateProvider.notifier).toggleOrganType();
    }

    if (isNewExam &&
        currentPoint.point.spot !=
            _ref.read(examinationStateProvider).currentSpot) {
      await _ref
          .read(examinationStateProvider.notifier)
          .switchSpot(currentPoint.point.spot);
    }

    // Updates the current spot with a new recording.
    _ref.read(examinationStateProvider.notifier).updateSpot(spot);

    _completeRecording();
  }

  Future<Record> save(
    ExaminationPoint currentPoint,
    File file,
    BodyPosition bodyPosition,
    String? recordId,
    RecordAnalysisStatus? analysisStatus,
  ) async {
    final result = await _saveRecordUseCase
        .execute(
          examinationPointId: currentPoint.id!,
          recordFile: file,
          bodyPosition: bodyPosition,
          id: recordId,
          analysisStatus: analysisStatus,
        )
        .toList();

    assert(result.isNotEmpty);
    return result.last;
  }

  void _completeRecording() {
    _setRecordingState(RecordingStates.finished);
    if (_router.current.name == StethoscopeRoute.name && _router.canPop()) {
      _router.pop();
    }
  }

  void _setRecordingState(RecordingStates value) {
    final recordingState = state.recordingState.copyWith(state: value);
    state = state.copyWith(recordingState: recordingState);
  }

  void rerecord() {
    _cancel();
    state = state.copyWith(recordingState: RecordingState());
    _initAudioEngine();
  }

  void close() {
    switch (state.recordingState.state) {
      case RecordingStates.ready:
      case RecordingStates.recording:
        if (_router.canPop()) _router.pop();
      case RecordingStates.saving:
        break;
      case RecordingStates.checkingQuality:
        break;
      case RecordingStates.finished:
        break;
    }
  }

  void onVerticalDragStart(DragStartDetails details) {
    _dragStartPoint = details.globalPosition.dy;
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    const dragDeltaDivider = 3;
    final delta = -1 * (details.globalPosition.dy - _dragStartPoint);
    _dragDelta += delta / dragDeltaDivider;
    if (_dragDelta.abs() >= state.activeFilter.gainStep) {
      setGain(
        state.gain +
            _dragDelta ~/
                state.activeFilter.gainStep *
                state.activeFilter.gainStep,
      );
      _dragDelta = 0;
    }

    _dragStartPoint = details.globalPosition.dy;
  }

  void onVerticalDragEnd(DragEndDetails details) {
    _dragDelta = 0;
  }

  Future<void> _handleEngineStateChange(Map<Object?, Object?> data) async {
    if (data['isEngineOn'] != true && _isCancelled == false) {
      final mode = _ref.read(stethoscopeModeProvider);

      if (mode == StethoscopeMode.recording && _isNotFinalPhase) {
        cancel();
        _router.popUntilRouteWithPath('/stethoscope');
        _router.pop();
      } else if (_isNotFinalPhase) {
        _router.pop();
      } else {
        // do nothing, the stethoscope will be closed
        // by the caller side
      }
    }
  }
}

enum RecordingStates {
  ready,
  recording,
  saving,
  checkingQuality,
  finished,
}

class RecordingState {
  RecordingState({this.state = RecordingStates.ready, int? timeLeft})
      : _timeLeft = timeLeft ?? Config.signalDuration.inSeconds;

  final RecordingStates state;
  final int _timeLeft;

  int get timeLeft => _timeLeft;

  RecordingState copyWith({RecordingStates? state, int? timeLeft}) {
    return RecordingState(
      state: state ?? this.state,
      timeLeft: timeLeft ?? this.timeLeft,
    );
  }
}

class StethoscopeState {
  StethoscopeState({
    this.isDoctorMode,
    required this.isAudioEngineOn,
    this.mode = StethoscopeMode.listening,
    this.activeFilter = Config.defaultHeartFilter,
    required this.recordingState,
    this.signal = const [],
    required this.filterGain,
    this.gainOpacity = 0,
    this.gain = 0,
    bool? microphoneDisabled,
  }) : isMicrophoneEnabled = microphoneDisabled;

  final bool? isDoctorMode;
  final AsyncValue<String> isAudioEngineOn;
  final StethoscopeMode mode;
  final Filters activeFilter;
  final RecordingState recordingState;
  final List<double> signal;
  final double gainOpacity;
  final int gain;
  final Map<Filters, int> filterGain;
  final bool? isMicrophoneEnabled;

  StethoscopeState copyWith({
    bool? isDoctorMode,
    AsyncValue<String>? isAudioEngineOn,
    StethoscopeMode? mode,
    Filters? activeFilter,
    RecordingState? recordingState,
    List<double>? signal,
    Map<Filters, int>? filterGain,
    double? gainOpacity,
    int? gain,
    bool? microphoneDisabled,
  }) {
    return StethoscopeState(
      isAudioEngineOn: isAudioEngineOn ?? this.isAudioEngineOn,
      mode: mode ?? this.mode,
      activeFilter: activeFilter ?? this.activeFilter,
      recordingState: recordingState ?? this.recordingState,
      signal: signal ?? this.signal,
      filterGain: filterGain ?? this.filterGain,
      gainOpacity: gainOpacity ?? this.gainOpacity,
      gain: gain ?? this.gain,
      microphoneDisabled: microphoneDisabled ?? isMicrophoneEnabled,
      isDoctorMode: isDoctorMode ?? this.isDoctorMode,
    );
  }
}

const _micPermissionIconPath = 'assets/images/microphone.svg';
