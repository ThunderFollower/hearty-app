import '../biometric.dart';

class IOSBiometric implements Biometric {
  @override
  final bool isEnabled;

  @override
  final String? label;

  IOSBiometric({required this.isEnabled, this.label});
}
