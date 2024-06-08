part of 'spectrogram_generator_impl.dart';

const double _spectrogramCutoff = 0.000001;
const double _spectrogramAmplificationQuotient = 2 / 3;

List<Float32List> rawData = [];
const colorMap = [
  {'p': 0, 'r': 255, 'g': 255, 'b': 255},
  {'p': 0.1, 'r': 0, 'g': 99, 'b': 147},
  {'p': 0.2, 'r': 53, 'g': 167, 'b': 182},
  {'p': 0.3, 'r': 0, 'g': 213, 'b': 191},
  {'p': 0.35, 'r': 21, 'g': 255, 'b': 232},
  {'p': 0.4, 'r': 255, 'g': 255, 'b': 15},
  {'p': 0.55, 'r': 244, 'g': 57, 'b': 11},
  {'p': 0.8, 'r': 255, 'g': 100, 'b': 100},
  {'p': 0.9, 'r': 255, 'g': 150, 'b': 150},
  {'p': 1, 'r': 255, 'g': 255, 'b': 255},
];
const colorMapSize = 0x200;

Uint8List _draw(List<Float32List> rawData) {
  final data = _enhanceData(rawData);
  final colors = _updateMappingRGBArrays();
  final red = colors[0];
  final green = colors[1];
  final blue = colors[2];

  final height = data.length ~/ 2;
  final width = data[0].length;
  final rgba = Uint8List(height * width * 4);
  int offs = 0;
  for (int j = height; j < data.length; j++) {
    for (int i = 0; i < width; i++) {
      final color = (data[j][i] * (colorMapSize - 1)).truncate();
      rgba[offs++] = red[color];
      rgba[offs++] = green[color];
      rgba[offs++] = blue[color];
      rgba[offs++] = 255;
    }
  }

  return rgba;
}

List<Uint8List> _updateMappingRGBArrays() {
  final r = Uint8List(colorMapSize);
  final g = Uint8List(colorMapSize);
  final b = Uint8List(colorMapSize);
  for (int k = 0; k < (colorMap.length - 1); k++) {
    final from = colorMap[k];
    final to = colorMap[k + 1];
    final start = (from['p']! * colorMapSize).truncate();
    final end = (to['p']! * colorMapSize).truncate();
    final width = end - start;
    if (width <= 0) {
      continue;
    }
    final deltaR = (to['r']! - from['r']!) / width;
    final deltaG = (to['g']! - from['g']!) / width;
    final deltaB = (to['b']! - from['b']!) / width;
    for (int i = 0; i < width; i++) {
      r[start + i] = (from['r']! + deltaR * i).round();
      g[start + i] = (from['g']! + deltaG * i).round();
      b[start + i] = (from['b']! + deltaB * i).round();
    }
  }

  return [r, g, b];
}

List<Float32List> _enhanceData(List<Float32List> rawData) {
  for (int i = 0; i < rawData.length; i++) {
    final row = rawData[i];
    rawData[i] = Float32List.fromList(
      row.map((el) => _enhance(el, _spectrogramCutoff)).toList(),
    );
  }

  return rawData;
}

double _enhance(double x, double cutoff) {
  double output = x - cutoff;
  output /= 1 - cutoff;
  if (output < 0) {
    output = 0;
  }
  return pow(output, _spectrogramAmplificationQuotient).toDouble();
}
