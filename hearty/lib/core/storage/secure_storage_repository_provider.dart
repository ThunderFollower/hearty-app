import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local/secure_storage_repository.dart';
import 'object_storage.dart';

final secureStorageRepositoryProvider = Provider.autoDispose<ObjectStorage>(
  (ref) => SecureStorageRepository(ref),
);
