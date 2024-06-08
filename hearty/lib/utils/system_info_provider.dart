import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'system_info.dart';

/// Provides a [SystemInfo] service.
final systemInfoProvider = Provider<SystemInfo>(
  (ref) {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return SystemInfo(deviceInfoPlugin: deviceInfoPlugin);
  },
);
