part of 'record_controller_impl.dart';

mixin _Player on _Base {
  /// The original recording sample rate is 48 KHz.
  static const sampleRate = int.fromEnvironment(
    'ORIGINAL_SAMPLE_RATE',
    defaultValue: 48000,
  );

  late Ticker _ticker;

  Future<void> _initPlayer() async {
    WidgetsBinding.instance.addObserver(this);
    _ticker = Ticker(_onTick);
    if (Platform.isIOS) {
      await player.setAudioFocus(device: AudioDevice.blueToothA2DP);
    }

    state = state.copyWith(
      isPlaying: state.audioUri == null ? null : false,
      position: Duration.zero,
    );
  }

  Future<void> _openAudioSession() async {
    await player.openAudioSession(
      device: AudioDevice.blueToothA2DP,
      audioFlags: allowHeadset |
          allowEarPiece |
          allowBlueToothA2DP |
          outputToSpeaker |
          allowAirPlay,
    );
  }

  void _startAnimation([Duration? duration]) {
    _ticker.start();
    state = state.copyWith(
      isPlaying: true,
      duration: duration,
      startPosition: state.position,
    );
  }

  void _stopAnimation() {
    _ticker.stop();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> _onTick(Duration elapsed) async {
    final playerState = await player.getPlayerState();
    if (playerState != PlayerState.isPlaying) {
      _stop();
      return;
    }

    final startPosition = state.startPosition ?? Duration.zero;
    final speed = state.speed ?? 1.0;
    final position = startPosition + elapsed * speed;

    state = state.copyWith(position: position);
  }

  Future<void> _disposePlayer() {
    _ticker.dispose();
    WidgetsBinding.instance.removeObserver(this);
    return player.stopPlayer();
  }

  Future<void> _playOrResume() async {
    if (state.audioUri == null) return;
    final playerState = await player.getPlayerState();
    if (playerState == PlayerState.isPaused) {
      return _resume();
    }
    return _play();
  }

  Future<void> _play() async {
    final playerState = await player.getPlayerState();
    final audioUri = state.audioUri ?? '';
    if (audioUri.isEmpty ||
        playerState == PlayerState.isPlaying ||
        _ticker.isActive) return;

    try {
      _normalizePosition();
      await _restorePlayer();
      final duration = await player.startPlayer(
        fromURI: audioUri,
        codec: Codec.pcmFloat32,
        sampleRate: sampleRate,
        whenFinished: _handleFinishedPayback,
      );

      _startAnimation(duration);
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  Future<void> _stop() async {
    final playerState = await player.getPlayerState();
    if (playerState != PlayerState.isStopped) {
      await player.stopPlayer();
    }
    _stopAnimation();
  }

  Future<void> _resume() async {
    try {
      _normalizePosition();
      await _restorePlayer();

      final playerState = await player.getPlayerState();
      if (playerState != PlayerState.isPaused || _ticker.isActive) return;
      await player.resumePlayer();
      assert(!_ticker.isActive);
      _startAnimation();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  void _handleFinishedPayback() {
    _stopAnimation();
    state = state.copyWith(
      position: Duration.zero,
    );
    int repeatTimes = state.playbackRepeatCounter - 1;
    if (repeatTimes > 0) {
      _play();
    } else {
      repeatTimes = Config.recordPlaybackRepeatTimes;
    }
    state = state.copyWith(
      playbackRepeatCounter: repeatTimes,
    );
  }

  Future<void> _pause() async {
    final playerState = await player.getPlayerState();
    if (playerState != PlayerState.isPlaying && !_ticker.isActive) return;
    try {
      await player.pausePlayer();
      _stopAnimation();
    } catch (error, stackTrace) {
      _handleError(error, stackTrace);
    }
  }

  Future<void> _restorePlayer() async {
    final position = state.position;
    if (position != null) await player.seekToPlayer(position);

    final speed = state.speed;
    if (speed != null) await player.setSpeed(speed);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        if (player.isOpen()) _pause();
      default:
        break;
    }
  }

  void _normalizePosition() {
    final position = state.position;
    final duration = state.duration ?? Duration.zero;
    if (position == null || position.isNegative || position >= duration) {
      state = state.copyWith(position: Duration.zero);
    }
  }
}
