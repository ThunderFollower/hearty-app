import 'dart:math' as math;
import 'dart:typed_data';

class SoundUtils {
  SoundUtils._();

  static Float32List createHanningWindow(int width) {
    final window = Float32List(width);
    for (int i = 0; i < width; i++) {
      window[i] = 0.5 - 0.5 * math.cos(2 * math.pi * i / (width - 1));
    }
    return window;
  }
}
