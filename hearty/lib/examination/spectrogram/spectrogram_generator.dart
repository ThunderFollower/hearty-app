import 'dart:ui';

abstract class SpectrogramGenerator {
  Stream<Image> execute(Iterable<double> signal);
}
