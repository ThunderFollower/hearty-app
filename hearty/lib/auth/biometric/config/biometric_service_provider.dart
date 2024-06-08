import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../core/core.dart';
import '../biometric_service.dart';
import '../impl/ios_biometric_service_adapter.dart';

final biometricServiceProvider = Provider.autoDispose<BiometricService>(
  (ref) {
    final iosBiometricServiceAdapter = IOSBiometricServiceAdapter(
      ref.read(sharedPreferencesProvider.future),
      Logger(),
    );
    ref.onDispose(iosBiometricServiceAdapter.dispose);
    return iosBiometricServiceAdapter;
  },
);
