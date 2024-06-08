import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'get_iphone_name.dart';

class UserAgentBuilder {
  UserAgentBuilder._();

  static Future<String> build() async {
    String userAgent = '';
    if (Platform.isIOS) {
      userAgent = await _getIosUserAgentHeader();
    } else {
      throw UnsupportedError('Unsupported platform');
    }

    return '$userAgent ${await _getPackageInfo()}';
  }

  static Future<String> _getPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}(${packageInfo.buildNumber})';
  }

  static Future<String> _getIosUserAgentHeader() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    final deviceId = iosInfo.identifierForVendor ?? '';
    final model = iosInfo.utsname.machine;
    final version = iosInfo.systemVersion;

    return '$deviceId ${getIPhoneName(model)} $version';
  }
}
