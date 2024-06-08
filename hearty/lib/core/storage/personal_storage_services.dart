import 'package:async/async.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/index.dart';
import 'local_storage_provider.dart';
import 'object_storage.dart';
import 'secure_storage_repository_provider.dart';

final personalStorageService = Provider.autoDispose<ObjectStorage>(
  (ref) {
    final storage = ref.read(localStorageProvider);
    return PersonalStorageDecorator(ref, storage);
  },
);

final personalSecureStorageService = Provider.autoDispose(
  (ref) {
    final storage = ref.read(secureStorageRepositoryProvider);
    return PersonalStorageDecorator(ref, storage);
  },
);

// TODO: refactor this `PersonalStorageDecorator`
class PersonalStorageDecorator implements ObjectStorage {
  final Ref _ref;
  final ObjectStorage _storage;

  PersonalStorageDecorator(this._ref, this._storage);

  String get _email => _ref.read(emailProvider);

  String _buildPersonalKey(String key, [String? login]) {
    final suffix = _getKeySuffix(login);
    return '$suffix$key';
  }

  /// Optional `login` is here to remove personal data without authorization.
  /// f.e. cache of any account from the list of accounts.
  @override
  Future<void> remove(String key, [String? login]) =>
      _storage.remove(_buildPersonalKey(key, login));

  @override
  Future<bool> contains(String key) async {
    if (_email.isNotEmpty) {
      return _storage.contains(_buildPersonalKey(key));
    }
    return false;
  }

  @override
  Future<T> get<T>(String key) => _storage.get(_buildPersonalKey(key));

  @override
  Future<void> put(String key, Object object) =>
      _storage.put(_buildPersonalKey(key), object);

  /// Removes all items from the storage that belong to the current user.
  ///
  /// Returns a [Future] that completes with `null` when all items have been
  /// removed, or with an error if the operation fails.
  @override
  Future<void> clear() =>
      _streamRawKeys().asyncMap((event) => _storage.remove(event)).firstOrNull;

  @override
  Future<Iterable<String>> getKeys() {
    final suffix = _getKeySuffix();
    return _streamRawKeys()
        .map((event) => event.substring(suffix.length))
        .toSet();
  }

  String _getKeySuffix([String? login]) {
    final mail = login ?? _email;
    assert(mail.isNotEmpty, 'User must be authenticated');
    return '$mail-';
  }

  Stream<String> _streamRawKeys() {
    final suffix = _getKeySuffix();
    return _storage
        .getKeys()
        .asStream()
        .expand((element) => element)
        .where((event) => event.startsWith(suffix));
  }
}
