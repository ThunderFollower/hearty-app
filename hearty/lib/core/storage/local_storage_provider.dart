import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local/local_storage.dart';
import 'object_storage.dart';

final localStorageProvider = Provider.autoDispose<ObjectStorage>(
  (_) => LocalStorage(),
);
