import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../config.dart' as app_config;

class StorageCacheManager extends CacheManager {
  static const key = 'CachedData';

  static final StorageCacheManager _instance = StorageCacheManager._();
  factory StorageCacheManager() {
    return _instance;
  }

  StorageCacheManager._()
      : super(
          Config(
            key,
            maxNrOfCacheObjects: app_config.Config.maxCachedFiles,
            stalePeriod: app_config.Config.cacheTime,
          ),
        );
}
