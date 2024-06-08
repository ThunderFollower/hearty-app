import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../object_storage.dart';
import 'missing_element_exception.dart';

class LocalStorage implements ObjectStorage {
  Future<SharedPreferences> _storage() => SharedPreferences.getInstance();

  @override
  Future<bool> contains(String key) async {
    return (await _storage()).containsKey(key);
  }

  @override
  Future<T> get<T>(String key) async {
    final string = (await _storage()).getString(key);
    if (string == null) {
      throw MissingElementException(key);
    }
    return jsonDecode(string) as T;
  }

  @override
  Future<void> remove(String key) async {
    (await _storage()).remove(key);
  }

  @override
  Future<void> put(String key, Object object) async {
    final string = jsonEncode(object);
    (await _storage()).setString(key, string);
  }

  @override
  Future<void> clear() async => (await _storage()).clear();

  @override
  Future<Iterable<String>> getKeys() async {
    return (await _storage()).getKeys();
  }
}
