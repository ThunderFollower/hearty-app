import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

import 'audio_engine.dart';

/// Enum defining method names for method channel calls.
enum _Methods {
  turnOnAudioEngine,
  turnOffAudioEngine,
  turnOnRecord,
  turnOffRecord,
  setMode,
  setGain,
  postProcess,
}

/// Enum defining argument keys for method channel calls.
enum _Arguments {
  uri,
  name,
  mode,
  gain,
  declicker,
}

/// An implementation of [AudioEngine] for iOS.
class AudioEngineImpl implements AudioEngine {
  AudioEngineImpl(
    this.audioEngineChannel,
  );

  @protected
  final MethodChannel audioEngineChannel;

  int _gain = 100;
  int _mode = 0;

  @override
  int get gain => _gain;

  @override
  set gain(int gain) {
    _gain = gain;
    unawaited(setGain(gain));
  }

  @override
  int get mode => _mode;

  @override
  set mode(int mode) {
    _mode = mode;
    unawaited(setMode(mode, gain: _gain));
  }

  @override
  Future<DoubleList2String> applyEffect(
    String path, {
    String? cacheKey,
    int? effect,
    int? gain,
    bool? declicker,
  }) async {
    if (gain != null) _gain = gain;
    final result = await audioEngineChannel.invokeMethod<Map>(
      _Methods.postProcess.name,
      {
        _Arguments.uri.name: path,
        _Arguments.name.name: cacheKey,
        _Arguments.mode.name: effect,
        _Arguments.gain.name: gain,
        _Arguments.declicker.name: declicker,
      },
    );

    final filtered = (result?['filteredSignal'] as Iterable).cast<double>();
    final signal = (result?['rawSignal'] as Iterable).cast<double>();
    final cachePath = result?['filePath'] as String;

    return Tuple3(signal, filtered, cachePath);
  }

  @override
  Future<String?> setup({
    required int mode,
    required int gain,
    required bool declicker,
  }) {
    _mode = mode;
    _gain = gain;

    return audioEngineChannel.invokeMethod<String>(
      _Methods.turnOnAudioEngine.name,
      {
        _Arguments.mode.name: mode,
        _Arguments.gain.name: gain,
        _Arguments.declicker.name: declicker ? 1 : 0,
      },
    );
  }

  @override
  Future<void> close() => audioEngineChannel.invokeMethod<void>(
        _Methods.turnOffAudioEngine.name,
      );

  @override
  Future<void> startRecording() => audioEngineChannel.invokeMethod<void>(
        _Methods.turnOnRecord.name,
      );

  @override
  Future<String?> finishRecording() => audioEngineChannel.invokeMethod<String>(
        _Methods.turnOffRecord.name,
      );

  Future<void> setMode(int mode, {required int gain}) =>
      audioEngineChannel.invokeMethod(
        _Methods.setMode.name,
        {
          _Arguments.mode.name: mode,
          _Arguments.gain.name: gain,
        },
      );

  Future<void> setGain(int gain) => audioEngineChannel.invokeMethod(
        _Methods.setGain.name,
        {
          _Arguments.gain.name: gain,
        },
      );
}
