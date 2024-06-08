import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import 'migration_helper.dart';

/// Creates and returns a new database or opens an existing one at the specified [path].
///
/// Uses the provided [helper] to handle database migration tasks such as creating,
/// upgrading, and opening actions. In case of an error when opening the database,
/// it will attempt to delete the potentially corrupt database file and create a new one.
///
/// [password] can be provided to encrypt the database using SQLCipher.
///
/// Returns a Future that resolves to the [Database] instance.
///
/// Throws an exception if it fails to open the database on the second attempt after deletion.
Future<Database> createDatabase(
  String path, {
  required MigrationHelper helper,
  String? password,
}) async {
  final logger = Logger();
  if (kDebugMode) {
    logger.d('Opening database: $path');
  }
  try {
    final database = await _openDatabase(
      path,
      helper: helper,
      password: password,
    );
    return database;
  } catch (error) {
    logger.e('Failed to open database: $path');
    File(path).delete(recursive: true);
    return _openDatabase(
      path,
      helper: helper,
      password: password,
    );
  }
}

Future<Database> _openDatabase(
  String path, {
  required MigrationHelper helper,
  String? password,
}) =>
    openDatabase(
      path,
      version: helper.latestVersion,
      onCreate: helper.onCreate,
      onUpgrade: helper.onUpgrade,
      onOpen: helper.onOpen,
      password: password,
    );
