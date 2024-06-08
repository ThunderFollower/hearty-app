import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';

final secureStorageService = Provider.autoDispose<SecureStorageService>(
  (ref) => SecureStorageService(ref),
);

class SecureStorageService {
  SecureStorageService(this._ref) {
    _storageRepository = _ref.read(secureStorageRepositoryProvider);
  }

  final Ref _ref;
  late final ObjectStorage _storageRepository;

  Future<void> remove(String key) => _storageRepository.remove(key);

  Future<bool> contains(String key) => _storageRepository.contains(key);

  Future<T> get<T>(String key) async => await _storageRepository.get(key) as T;

  Future<void> put(String key, Object object) =>
      _storageRepository.put(key, object);
}
