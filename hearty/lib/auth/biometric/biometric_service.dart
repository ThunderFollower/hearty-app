import 'biometric.dart';

abstract class BiometricService {
  BiometricService();

  Stream<Biometric> observeBiometricChanges();

  Future<void> init();

  Future<void> enableBiometric();

  Future<void> disableBiometric();

  Future<void> authenticate();

  void createBiometricsRequest([dynamic data]);

  Stream<dynamic> listenBiometricsRequest();
}
