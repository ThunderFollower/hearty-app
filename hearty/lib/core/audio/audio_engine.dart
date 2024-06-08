import 'package:tuple/tuple.dart';

/// Defines a type alias for a tuple containing 2 lists of doubles and a string.
typedef DoubleList2String = Tuple3<Iterable<double>, Iterable<double>, String>;

/// An abstract class that defines the contract for platform-specific store
/// audio sub-system.
abstract class AudioEngine {
  /// Applies an audio effect to the file specified by [fileName] and returns a
  /// tuple of 2 lists of doubles and a string.
  /// - Returns: A future that resolves to a [DoubleList2String].
  Future<DoubleList2String> applyEffect(
    String fileName, {
    String? cacheKey,
    int? effect,
    int? gain,
    bool? declicker,
  });

  /// The current gain level of the audio recording.
  int get gain;
  set gain(int gain);

  /// The current mode of the audio engine.
  int get mode;
  set mode(int mode);

  /// Initializes the audio engine using the provided [mode], [gain], and
  /// [declicker] settings in preparation for recording or processing audio.
  Future<String?> setup({
    required int mode,
    required int gain,
    required bool declicker,
  });

  /// Closes the audio engine, ensuring that all resources are properly
  /// released. This method should be called when the audio engine is no longer
  /// needed to prevent resource leaks.
  Future<void> close();

  /// Initiates recording of audio. This method should be called after the audio
  /// engine has been properly configured, see [AudioEngine.setup], and is ready
  /// to capture audio.
  Future<void> startRecording();

  /// Completes the audio recording process and returns the recording.
  ///
  /// Completes the audio recording and finalizes the audio file. This method
  /// may return the name or path of the recorded audio file, if applicable.
  /// - Returns: A future that resolves to an optional string indicating the
  ///   name or path of the recorded audio file.
  Future<String?> finishRecording();
}
