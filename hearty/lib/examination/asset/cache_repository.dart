import 'dart:typed_data';

import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config.dart';
import 'cache_manager.dart';
import 'config/storage_cache_provider.dart';

final cacheRepositoryProvider = Provider.autoDispose<CacheRepository>(
  (ref) => CacheRepository(cacheManager: ref.read(storageCacheProvider)),
);

class CacheRepository {
  final StorageCacheManager _cacheManager;

  CacheRepository({required StorageCacheManager cacheManager})
      : _cacheManager = cacheManager;

  Future<String> save({required Uint8List bytes, required String name}) async {
    final file = await _cacheManager.putFile(
      name,
      bytes,
      key: name,
      eTag: name,
      maxAge: Config.cacheTime,
    );
    return file.path;
  }

  Future<String> saveAsset({
    required Uint8List bytes,
    required String name,
  }) async {
    final file = await _cacheManager.putFile(
      name,
      bytes,
      key: name,
      eTag: name,
      maxAge: Config.cacheTime,
    );
    return file.path;
  }

  Future<String?> getUri(String name) async {
    final data = await _cacheManager.getFileFromCache(name);
    return data?.file.path;
  }

  Future<File?> getFile(String name) async {
    final data = await _cacheManager.getFileFromCache(name);
    return data?.file;
  }
}
