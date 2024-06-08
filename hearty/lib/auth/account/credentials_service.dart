import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import 'entities/credentials.dart';
import 'entities/credentials_set.dart';

final credentialsServiceProvider = Provider.autoDispose(
  (ref) {
    final credentialsService = CredentialsService(ref);
    ref.onDispose(credentialsService.dispose);
    return credentialsService;
  },
);

const _key = '_credentials';

class CredentialsService {
  final Ref _ref;
  late final SecureStorageService _storageService;
  final _dataController = StreamController<List<Credentials>>.broadcast();

  CredentialsService(this._ref) {
    _storageService = _ref.read(secureStorageService);
  }

  void dispose() {
    _dataController.close();
  }

  Future<void> save({required String login, required String password}) async {
    try {
      final account = Credentials(login: login, password: password);
      final original = await get();
      final updated = original.add(account);
      await _storageService.put(_key, updated);
      _dataController.add(updated.data.toList());
    } on Exception {
      rethrow;
    }
  }

  Future<void> remove({required String login}) async {
    try {
      final original = await get();
      final updated = original.remove(login);
      await _storageService.put(_key, updated);
      _dataController.add(updated.data.toList());
    } on Exception {
      rethrow;
    }
  }

  Future<CredentialsSet> get() async {
    return await _storageService.contains(_key)
        ? CredentialsSet.fromJson(
            await _storageService.get<Map<String, dynamic>>(_key),
          )
        : const CredentialsSet();
  }

  Future<bool> hasCredentials() async => (await get()).isNotEmpty;

  /// Look for all credentials in storage and return them as a list.
  ///
  /// Returns a cold [Stream] that emits a [List] of [Credentials].
  Stream<List<Credentials>> load() async* {
    final credentialsSet = await get();
    yield credentialsSet.data.toList();
  }

  /// Return a hot [Stream] that emits a [List] of [Credentials] when
  ///  the list is changed.
  Stream<List<Credentials>> get updates => _dataController.stream;

  /// Look for all credentials in storage and all changes to them.
  ///
  /// Returns a [Stream] that emits a [List] of [Credentials].
  Stream<List<Credentials>> all() async* {
    yield* load();
    yield* updates;
  }
}
