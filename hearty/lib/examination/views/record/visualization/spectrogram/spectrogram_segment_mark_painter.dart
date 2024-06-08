part of 'spectrogram_segment_mark.dart';

const _dashWidth = 9;
const _dashSpace = 5;
const _strokeWidth = 1.0;

class _Painter extends CustomPainter {
  final Color color;

  _Painter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + _dashWidth),
        paint,
      );
      canvas.drawLine(
        Offset(size.width, startY),
        Offset(size.width, startY + _dashWidth),
        paint,
      );
      startY += _dashWidth + _dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
