import 'package:vibration/vibration.dart';

Future<void> vibrate() async {
  if (await Vibration.hasVibrator() ?? false) {
    Vibration.vibrate();
  }
}
