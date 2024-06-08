// ignore_for_file: parameter_assignments, non_constant_identifier_names

import 'dart:math' as math;

import 'base_complex_array.dart';

class ComplexArray extends BaseComplexArray {
  ComplexArray(super.length);

  ComplexArray.fromList(super.list) : super.fromList();

  ComplexArray FFT() {
    return _fft(this);
  }

  ComplexArray InvFFT() {
    return _fft(this, inverse: true);
  }
}

ComplexArray FFT(ComplexArray input) {
  return ensureComplexArray(input).FFT();
}

ComplexArray InvFFT(ComplexArray input) {
  return ensureComplexArray(input).InvFFT();
}

ComplexArray ensureComplexArray(dynamic input) {
  return input.runtimeType == ComplexArray
      ? (input as ComplexArray)
      : ComplexArray.fromList(input as List<double>);
}

ComplexArray _fft(ComplexArray input, {bool inverse = false}) {
  final n = input.length;

  if (n & (n - 1) != 0) {
    return FFT_Recursive(input, inverse: inverse);
  }
  return FFT_2_Iterative(input, inverse: inverse);
}

ComplexArray FFT_Recursive(ComplexArray input, {bool inverse = false}) {
  final n = input.length;

  if (n == 1) {
    return input;
  }

  final output = ComplexArray(n);

  // Use the lowest odd factor, so we are able to use FFT_2_Iterative in the
  // recursive transforms optimally.
  final p = lowestOddFactor(n);
  final m = (n / p).truncate();
  final normalized = 1 / math.sqrt(p);
  ComplexArray recursiveResult = ComplexArray(m);

  // Loops go like O(n Σ p_i), where p_i are the prime factors of n.
  // for a power of a prime, p, this reduces to O(n p log_p n)
  for (int j = 0; j < p; j++) {
    for (int i = 0; i < m; i++) {
      recursiveResult.real[i] = input.real[i * p + j];
      recursiveResult.magnified[i] = input.magnified[i * p + j];
    }
    // Don't go deeper unless necessary to save allocations.
    if (m > 1) {
      recursiveResult = _fft(recursiveResult, inverse: inverse);
    }

    final delFR = math.cos((2 * math.pi * j) / n);
    final delFI = (inverse ? -1 : 1) * math.sin((2 * math.pi * j) / n);
    double fR = 1;
    double fI = 0;

    for (int i = 0; i < n; i++) {
      final real = recursiveResult.real[i % m];
      final iMag = recursiveResult.magnified[i % m];

      output.real[i] += fR * real - fI * iMag;
      output.magnified[i] += fR * iMag + fI * real;

      final t = fR;
      fR = t * delFR - fI * delFI;
      fI = t * delFI + fI * delFR;
    }
  }

  // Copy back to input to match FFT_2_Iterative in-places
  for (int i = 0; i < n; i++) {
    input.real[i] = normalized * output.real[i];
    input.magnified[i] = normalized * output.magnified[i];
  }

  return input;
}

ComplexArray FFT_2_Iterative(ComplexArray input, {bool inverse = false}) {
  final n = input.length;

  final output = bitReverseComplexArray(input);
  final outputR = output.real;
  final outputI = output.magnified;
  // Loops go like O(n log n):
  //   width ~ log n; i,j ~ n
  int width = 1;
  while (width < n) {
    final delFR = math.cos(math.pi / width);
    final delFI = (inverse ? -1 : 1) * math.sin(math.pi / width);
    for (int i = 0; i < n / (2 * width); i++) {
      double fR = 1;
      double fI = 0;
      for (int j = 0; j < width; j++) {
        final lIndex = 2 * i * width + j;
        final rIndex = lIndex + width;

        final leftR = outputR[lIndex];
        final leftI = outputI[lIndex];
        final rightR = fR * outputR[rIndex] - fI * outputI[rIndex];
        final rightI = fI * outputR[rIndex] + fR * outputI[rIndex];

        outputR[lIndex] = math.sqrt1_2 * (leftR + rightR);
        outputI[lIndex] = math.sqrt1_2 * (leftI + rightI);
        outputR[rIndex] = math.sqrt1_2 * (leftR - rightR);
        outputI[rIndex] = math.sqrt1_2 * (leftI - rightI);

        final t = fR;
        fR = t * delFR - fI * delFI;
        fI = t * delFI + fI * delFR;
      }
    }
    width <<= 1;
  }

  return output;
}

int bitReverseIndex(int index, int n) {
  int bitReversedIndex = 0;

  while (n > 1) {
    bitReversedIndex <<= 1;
    bitReversedIndex += index & 1;
    index >>= 1;
    n >>= 1;
  }
  return bitReversedIndex;
}

ComplexArray bitReverseComplexArray(ComplexArray array) {
  final n = array.length;
  final flips = <int>{};

  for (int i = 0; i < n; i++) {
    final rI = bitReverseIndex(i, n);

    if (flips.contains(i)) continue;
    var tmp = array.real[i];
    array.real[i] = array.real[rI];
    array.real[rI] = tmp;
    tmp = array.magnified[i];
    array.magnified[i] = array.magnified[rI];
    array.magnified[rI] = tmp;

    flips.add(rI);
  }

  return array;
}

int lowestOddFactor(int n) {
  final sqrtN = math.sqrt(n);
  int factor = 3;

  while (factor <= sqrtN) {
    if (n % factor == 0) return factor;
    factor += 2;
  }
  return n;
}
