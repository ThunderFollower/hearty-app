import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../core/storage/index.dart';
import 'entities/device_identifier.dart';

final deviceIdentifierService = Provider.autoDispose<DeviceIdentifierService>(
  (ref) {
    final storage = ref.watch(secureStorageRepositoryProvider);
    return DeviceIdentifierService(secureStorage: storage);
  },
);

class DeviceIdentifierService {
  const DeviceIdentifierService({required this.secureStorage});

  final ObjectStorage secureStorage;

  Future<String> getDeviceIdentifier() async {
    return await secureStorage.contains(_key)
        ? _getDeviceIdentifier()
        : _createDeviceIdentifier();
  }

  Future<String> _getDeviceIdentifier() async {
    final json = await secureStorage.get<Map<String, dynamic>>(_key);
    return DeviceIdentifier.fromJson(json).deviceIdentifier;
  }

  Future<String> _createDeviceIdentifier() async {
    final deviceId = const Uuid().v4();
    await secureStorage.put(
      _key,
      DeviceIdentifier(deviceIdentifier: deviceId),
    );
    return deviceId;
  }
}

const String _key = 'device_identifier';
