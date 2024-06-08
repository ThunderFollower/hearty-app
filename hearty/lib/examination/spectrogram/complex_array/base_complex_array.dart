import 'dart:math' as math;
import 'dart:typed_data';

class BaseComplexArray {
  late Float32List real;
  late Float32List magnified;
  late int length;

  BaseComplexArray(this.length)
      : real = Float32List(length),
        magnified = Float32List(length);

  BaseComplexArray.fromList(List<double> list)
      : real = Float32List.fromList(list),
        magnified = Float32List(list.length),
        length = list.length;

  void forEach(Function(double, double, int, int) iterator) {
    for (int i = 0; i < length; i++) {
      iterator(real[i], magnified[i], i, length);
    }
  }

  BaseComplexArray map(Function(double, double, int, int) mapper) {
    forEach((double real, double magnified, int i, int n) {
      mapper(real, magnified, i, n);
      this.real[i] = real;
      this.magnified[i] = magnified;
    });

    return this;
  }

  Float32List magnitude() {
    final mags = Float32List(length);

    forEach(
      (double real, double magnified, int i, int _) =>
          mags[i] = math.sqrt(real * real + magnified * magnified),
    );

    return mags;
  }
}
