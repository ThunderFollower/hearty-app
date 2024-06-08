import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cache_manager.dart';

final storageCacheProvider =
    Provider.autoDispose<StorageCacheManager>((ref) => StorageCacheManager());
