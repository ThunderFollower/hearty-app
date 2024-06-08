import 'package:flutter/foundation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'migration_helper.dart';

/// A concrete implementation of the [MigrationHelper] which provides
/// logic for creating, upgrading, and opening a database.
class MigrationHelperImpl implements MigrationHelper {
  /// Creates a [MigrationHelperImpl] instance.
  ///
  /// [initialVersion] denotes the starting version of the database.
  /// [migrationScripts] are the SQL scripts that will be executed on a database
  /// upgrade.
  /// [openingScripts] are the SQL scripts that will be executed every time the
  /// database is opened.
  ///
  /// It's important that [initialVersion] starts from 1 and that the number of
  /// [migrationScripts]
  /// is equal to or greater than [initialVersion].
  const MigrationHelperImpl(
    this.initialVersion, {
    required this.migrationScripts,
    required this.openingScripts,
  })  : assert(initialVersion >= 1),
        assert(migrationScripts.length >= initialVersion);

  @override
  final int initialVersion;

  @override
  int get latestVersion => migrationScripts.length;

  /// SQL scripts that define the migrations for database upgrades.
  @protected
  final Iterable<Iterable<String>> migrationScripts;

  /// SQL scripts that are executed every time the database is opened.
  @protected
  final Iterable<Iterable<String>> openingScripts;

  @override
  Future<void> onCreate(Database db, int version) => onUpgrade(db, 0, version);

  @override
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (int i = oldVersion; i < newVersion; i++) {
      final scriptList = migrationScripts.elementAt(i);
      await executeMany(db, scriptList);
    }
  }

  @override
  Future<void> onOpen(Database db) async {
    for (final scriptList in openingScripts) {
      await executeMany(db, scriptList);
    }
  }

  @protected
  Future<void> executeMany(Database db, Iterable<String> scriptList) async {
    for (final script in scriptList) {
      await db.execute(script);
    }
  }
}
