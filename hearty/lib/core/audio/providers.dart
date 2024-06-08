import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'audio_engine.dart';
import 'audio_engine_impl.dart';

final audioEngineProvider = Provider.autoDispose<AudioEngine>(
  (ref) => AudioEngineImpl(
    const MethodChannel('sparrowacoustics.com/audioEngine'),
  ),
);
