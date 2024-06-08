import 'dart:typed_data';

class Spectro {
  final int width;
  final int height;
  final Uint8List data;

  const Spectro(this.width, this.height, this.data);
}
