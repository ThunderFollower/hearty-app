import 'package:sqflite_sqlcipher/sqflite.dart';

/// Defines an interface for migrating a database, including creating,
/// upgrading, and opening actions.
abstract class MigrationHelper {
  /// Represents the initial version of the database.
  int get initialVersion;

  /// Represents the latest version of the database.
  int get latestVersion;

  /// Method called when creating the database for the first time.
  ///
  /// [db] represents the database instance being created.
  /// [version] represents the version of the database.
  Future<void> onCreate(Database db, int version);

  /// Method called when upgrading the database from an older version to a newer version.
  ///
  /// [db] represents the database instance being upgraded.
  /// [oldVersion] represents the old version of the database.
  /// [newVersion] represents the new version of the database.
  Future<void> onUpgrade(Database db, int oldVersion, int newVersion);

  /// Method called when opening the database.
  ///
  /// [db] represents the database instance being opened.
  Future<void> onOpen(Database db);
}
