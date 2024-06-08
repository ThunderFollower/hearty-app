import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides an auto-disposable instance of [CacheManager] using [DefaultCacheManager].
final cacheManagerProvider = Provider.autoDispose<CacheManager>(
  (ref) => DefaultCacheManager(),
);
