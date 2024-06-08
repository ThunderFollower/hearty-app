import 'package:easy_localization/easy_localization.dart';

import '../../generated/locale_keys.g.dart';

class BiometricException implements Exception {
  const BiometricException();

  @override
  String toString() => LocaleKeys.Biometric_authentication_failed.tr();
}
