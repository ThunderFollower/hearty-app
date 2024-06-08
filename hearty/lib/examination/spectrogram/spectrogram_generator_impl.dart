import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../../../../../../../utils/utils.dart';
import 'complex_array/complex_array.dart';
import 'spectro.dart';
import 'spectrogram_generator.dart';

part 'spectrogram_generator_impl_draw.dart';

class SpectrogramGeneratorImpl implements SpectrogramGenerator {
  const SpectrogramGeneratorImpl();

  /// FFT specific parameter that defines how many samples at each sliding
  /// iteration are passed to FFT algorithm for transformation into a frequency
  /// domain.  Higher value gives better frequency resolution but lower time
  /// resolution.
  /// Should be an even integer.
  static const _fftWindowWidth = 352;

  /// Should be a power of 2. Also should be greater than or equal to
  /// fftWindowWidth.
  static const _fftExtendedWindowWidth = 4096;

  /// How many samples the FFT window jumps on each sliding iteration.
  /// It defines the time resolution of the resulting spectrogram.
  /// Minimal jump is 1, it corresponds to th highest resolution possible.
  static const _fftWindowJump = 16;

  /// The lower frequency level is 20 Hz.
  static const _lowerFrequency = int.fromEnvironment(
    'LOWER_FREQUENCY',
    defaultValue: 20,
  );

  /// The target sample rate is 4 KHz.
  static const _targetSampleRate = int.fromEnvironment(
    'TARGET_SAMPLE_RATE',
    defaultValue: 4000,
  );

  /// Hanning width corresponds to the window width. That is hanning is applied
  /// only to the central part of the segment.
  static Float32List hanningWindow =
      SoundUtils.createHanningWindow(_fftWindowWidth);

  @override
  Stream<Image> execute(Iterable<double> signal) async* {
    final emptySpectro = Spectro(1, 1, Uint8List.fromList([0, 0, 0, 0]));

    final spectro = signal.isNotEmpty
        ? await compute(generate, Float32List.fromList(signal.toList()))
        : emptySpectro;

    final subject = StreamController<Image>.broadcast();
    decodeImageFromPixels(
      spectro.data,
      spectro.width,
      spectro.height,
      PixelFormat.rgba8888,
      subject.add,
    );
    yield* subject.stream.take(1);
  }

  static Spectro generate(List<double> signal) {
    const start = 0;
    final end = signal.length;
    final top = (_targetSampleRate / 2).truncate();

    final bins = _calculateBinInterval(
      _lowerFrequency,
      top,
      _fftExtendedWindowWidth,
      _targetSampleRate,
    );

    // The  height of the spectrogram is the amount of bins we take from the ffT.
    // We don't check here that  bin index does not exceed windowWidth/2, falling
    // into negative frequencies. Just make sure that this.top frequency is less
    // than rate/2, and _calculateBinInterval will return proper values.
    final height = bins.top - bins.bottom + 1;
    final width = ((end - start) / _fftWindowJump).truncate();

    // Create the empty spectrogram - 2-dimensional array of floats
    final spectrogram = List.generate(height, (index) => Float32List(width));

    // Fill the spectrogram by sliding FFT window
    // Center alignment of the FFT window.
    final align = -(_fftWindowWidth / 2).truncate();
    for (int i = 0; i < width; i++) {
      final windowPosition = start + i * _fftWindowJump + align;
      final transform = _getFFT(
        signal,
        windowPosition,
        _fftWindowWidth,
        _fftExtendedWindowWidth,
        hanningWindow,
      );
      for (int j = 0; j < height; j++) {
        spectrogram[height - j - 1][i] = transform[bins.bottom + j];
      }
    }

    final normalizedSpectrogram = normalizeValues(spectrogram);
    final rgbData = _draw(normalizedSpectrogram);

    return Spectro(width, height ~/ 2, rgbData);
  }

  static _Bins _calculateBinInterval(
    int freqBottom,
    int freqTop,
    int windowWidth,
    int sampleRate,
  ) {
    // Utility function that calculates bounds for an interval of integers,
    // such that all numbers in the interval multiplied by bottom base frequency
    // (wavelength = windowWidth) lay between freqBottom and freqTop.
    final freqBase = sampleRate / windowWidth;
    int bottom = (freqBottom / freqBase).ceil();
    final top = (freqTop / freqBase).floor();
    bottom = bottom < 1 ? 1 : bottom;

    return _Bins(bottom, top);
  }

  static Float32List _getFFT(
    List<double> pcm,
    int windowPosition,
    int windowWidth,
    int extendedWindowWidth,
    Float32List hanningWindow,
  ) {
    // Prepare the PCM segment to be passed to FFT
    final segment = ComplexArray(extendedWindowWidth);
    final pcmSegment = Float32List(extendedWindowWidth);

    // Prepare the pcm segment to be passed to the FFT
    // All the involved variables should be even integers, so the result should be
    // an integer. This is to avoid slight signal aberrations on "half index"
    // alignment.
    final samplesPosition =
        ((extendedWindowWidth - windowWidth) / 2).truncate();
    // Take the values from original pcm signal.
    int srcIndex = 0;
    final maxSrcIndex = pcm.length;
    for (int i = 0; i < windowWidth; i++) {
      srcIndex = windowPosition + i;
      if (srcIndex < 0 || srcIndex >= maxSrcIndex) {
        // If the segment extends beyond the boundaries of the source pcm, which
        // is possible when taking the transform near the edges, fill the missing
        // values with zeroes.
        pcmSegment[samplesPosition + i] = 0;
        continue;
      }
      pcmSegment[samplesPosition + i] = pcm[srcIndex];
    }

    // Apply hanning to the segment
    for (int i = 0; i < windowWidth; i++) {
      pcmSegment[samplesPosition + i] *= hanningWindow[i];
    }

    segment.real = pcmSegment;

    // Apply the FFT
    final complexResult = FFT(segment);
    return complexResult.magnitude();
  }

  static List<Float32List> normalizeValues(List<Float32List> arr) {
    double max = arr[0][0];
    for (int j = 0; j < arr.length; j++) {
      final row = arr[j];
      for (int i = 0; i < row.length; i++) {
        if (max < row[i]) {
          max = row[i];
        }
      }
    }

    if (max == 0) {
      return arr;
    }

    final inverseMax = 1 / max;
    for (int j = 0; j < arr.length; j++) {
      final row = arr[j];
      for (int i = 0; i < row.length; i++) {
        row[i] *= inverseMax;
      }
    }

    return arr;
  }
}

class _Bins {
  final int bottom;
  final int top;

  _Bins(this.bottom, this.top);
}
