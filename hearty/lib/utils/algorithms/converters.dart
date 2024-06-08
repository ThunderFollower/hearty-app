import '../../config.dart';

double calculateTimePositionInPixels({
  required Duration duration,
  required Duration position,
  required double size,
}) {
  final factor = duration.inMicroseconds == 0
      ? 0.0
      : position.inMicroseconds / duration.inMicroseconds;

  return size * factor;
}

double normalizedTimestampToPixels(
  double timestamp, {
  required Duration duration,
  required double size,
}) {
  final seconds = duration.inSeconds == 0
      ? Config.signalDuration.inSeconds
      : duration.inSeconds;

  final step = size / seconds;
  final normalizedTime = timestamp > seconds ? seconds : timestamp;
  return normalizedTime * step;
}
