import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../../utils/utils.dart';
import '../core.dart';
import '../storage/local/config/secure_storage_provider.dart';
import 'database_factory.dart';
import 'migration_helper.dart';
import 'migration_helper_impl.dart';
import 'user/maintenance/index.dart';
import 'user/migrations/index.dart';

const _dbIdKey = 'db_id';
const _dbNameKey = 'db_name';
const _dbPasswordSalt = 'tk~.xH7=Pr@pHdtA';

const _sharedDatabaseLifespan = Duration(minutes: 2);
const _userDatabaseLifespan = Duration(minutes: 2);

/// Provides a future of an instance of the shared [Database].
final sharedDatabaseFutureProvider = FutureProvider.autoDispose<Database>(
  (ref) async {
    final database = await createDatabase(
      await ref.watch(_sharedDatabasePathProvider.future),
      password: await ref.watch(_sharedDatabasePasswordProvider.future),
      helper: ref.watch(_sharedMigrationHelperProvider),
    );
    ref.onDispose(database.close);
    ref.delayDispose(_sharedDatabaseLifespan);
    return database;
  },
);

/// Provides a future of a [Database] instance related to the current user.
final userDatabaseFutureProvider = FutureProvider.autoDispose<Database>(
  (ref) async {
    final key = await ref.watch(usersDatabaseKeyProvider.future);
    if (key == null) {
      return Future.error(const UnauthorizedException());
    }

    final database = await createDatabase(
      await ref.watch(_userDatabasePathProvider(key).future),
      password: await ref.watch(_userDatabasePasswordProvider(key).future),
      helper: ref.watch(_userMigrationHelperProvider),
    );
    ref.onDispose(database.close);
    ref.delayDispose(_userDatabaseLifespan);
    return database;
  },
);

/// Fetches a value for the provided key from the secure storage.
///
/// If the key doesn't exist, it generates and stores a new UUID as the value.
final usersDatabaseKeyProvider = StreamProvider.autoDispose<String?>(
  (ref) {
    throw UnimplementedError();
  },
);

/// Provides the complete path for the shared database.
///
/// For debug mode, it returns a static 'debug' path, and for other modes,
/// it fetches a unique name.
final _sharedDatabasePathProvider = FutureProvider.autoDispose<String>(
  (ref) async {
    final path = await getDatabasesPath();
    final name = kDebugMode
        ? 'debug'
        : await ref.read(_sharedDatabaseKeyProvider(_dbNameKey).future);
    return join(path, '$name.db');
  },
);

/// Provides an instance of [MigrationHelper] for migration tasks for the shared
/// [Database].
final _sharedMigrationHelperProvider = Provider.autoDispose<MigrationHelper>(
  (ref) => MigrationHelperImpl(
    1,
    migrationScripts: [],
    openingScripts: [],
  ),
);

/// Generates a password by combining a stored ID, a constant salt, and
/// a database secret.
///
/// This password is used to encrypt the shared database.
///
/// For debug mode, it returns `null`, i.e., no password.
final _sharedDatabasePasswordProvider = FutureProvider.autoDispose<String?>(
  (ref) async {
    if (kDebugMode) return null;
    final id = await ref.read(_sharedDatabaseKeyProvider(_dbIdKey).future);
    const dbSecret = String.fromEnvironment('DB_SECRET');
    return '$id:$_dbPasswordSalt:$dbSecret';
  },
);

/// Fetches a value for the provided key from the secure storage.
///
/// If the key doesn't exist, it generates and stores a new UUID as the value.
final _sharedDatabaseKeyProvider =
    FutureProvider.family.autoDispose<String, String>(
  (ref, key) async {
    final storage = ref.read(secureStorageProvider);

    var value = await storage.read(key: key);
    if (value == null) {
      value = const Uuid().v4();
      await storage.write(key: key, value: value);
    }

    return value;
  },
);

/// Provides the complete path for the user's database.
///
/// For debug mode, it returns a path with the '.debug.db' extension.
final _userDatabasePathProvider =
    FutureProvider.family.autoDispose<String, String>(
  (ref, key) async {
    final path = await getDatabasesPath();
    final name = kDebugMode ? '$key.debug' : key;
    return join(path, '$name.db');
  },
);

/// Provides an instance of [MigrationHelper] for migration tasks for the user's
/// database.
final _userMigrationHelperProvider = Provider.autoDispose<MigrationHelper>(
  (ref) => MigrationHelperImpl(
    1,
    migrationScripts: [
      userMigration001,
      userMigration002,
      userMigration003,
      userMigration004,
    ],
    openingScripts: [
      cleanupCardioFinding,
      cleanupCardioPoint,
      cleanupSegment,
    ],
  ),
);

/// Generates a password by combining shared password and the provided key.
///
/// This password is used to encrypt the user's database.
final _userDatabasePasswordProvider =
    FutureProvider.family.autoDispose<String?, String>(
  (ref, key) async {
    final sharedPassword = await ref.read(
      _sharedDatabasePasswordProvider.future,
    );
    return sharedPassword == null ? null : '$key:$sharedPassword';
  },
);
