import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'get_iphone_name.dart';

class SystemInfo {
  const SystemInfo({required this.deviceInfoPlugin});

  final DeviceInfoPlugin deviceInfoPlugin;

  Future<AndroidDeviceInfo> get androidInfo => deviceInfoPlugin.androidInfo;

  Future<String> get platformVersion async =>
      Platform.isAndroid ? _androidVersion : _iosVersion;

  Future<String> get deviceVersion async =>
      Platform.isAndroid ? _androidDeviceVersion : _iosDeviceVersion;

  Future<String> get appVersion async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}(${packageInfo.buildNumber})';
  }

  Future<IosDeviceInfo> get _iosInfo => deviceInfoPlugin.iosInfo;

  Future<String> get _iosVersion async => (await _iosInfo).systemVersion;

  Future<String> get _androidVersion async =>
      (await androidInfo).version.release;

  Future<String> get _androidDeviceVersion async {
    final AndroidDeviceInfo info = await androidInfo;
    final manufacturer = info.manufacturer;
    final model = info.model;
    final brand = info.brand;
    return '$brand $model $manufacturer';
  }

  Future<String> get _iosDeviceVersion async {
    final IosDeviceInfo info = await _iosInfo;
    final model = info.utsname.machine;

    return getIPhoneName(model);
  }

  String get localeName => Platform.localeName;

  String get platformName => Platform.operatingSystem;

  Future<String> get semanticAppVersion async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  String get mobilePlatformName => Platform.isIOS ? 'iOS' : 'Android';
}
