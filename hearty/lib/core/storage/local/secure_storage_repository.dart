import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../object_storage.dart';
import 'config/secure_storage_provider.dart';
import 'missing_element_exception.dart';

class SecureStorageRepository implements ObjectStorage {
  SecureStorageRepository(this._ref) {
    _storage = _ref.read(secureStorageProvider);
  }

  final Ref _ref;
  late final FlutterSecureStorage _storage;

  @override
  Future<bool> contains(String key) async {
    return await _storage.read(key: key) != null;
  }

  @override
  Future<T> get<T>(String key) async {
    final string = await _storage.read(key: key);
    if (string == null) {
      throw MissingElementException(key);
    }
    return jsonDecode(string) as T;
  }

  @override
  Future<void> remove(String key) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> put(String key, Object object) async {
    final string = jsonEncode(object);
    await _storage.write(key: key, value: string);
  }

  @override
  Future<void> clear() => _storage.deleteAll();

  @override
  Future<Iterable<String>> getKeys() =>
      _storage.readAll().asStream().map((event) => event.keys).first;
}
