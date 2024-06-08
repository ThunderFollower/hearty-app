import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../point.dart';
import '../point_repository.dart';
import 'entities/point_db_entity.dart';

/// Regulates the frequency of API requests related to [Point].
/// Although instances of [Point] are immutable and can technically last
/// forever, they are set to expire every 30 days. This is to refresh the cache
/// and remove outdated or unused data.
const _pointLifespan = Duration(days: 30);

/// A repository for [Point] entities backed by a local SQLite database.
///
/// This repository first tries to retrieve findings from the local database.
/// If the entity is not found locally, it falls back to another repository,
/// typically one that fetches from a remote source.
/// Once fetched from the remote source, the finding is then saved to the local
/// database for future queries.
class PointDbRepository implements PointRepository {
  /// Constructs a [PointDbRepository].
  ///
  /// The [fallbackRepository] is another source (typically remote) from which
  /// findings can be fetched if they aren't available in the local database.
  ///
  /// The [database] is the local SQLite database where findings are saved and
  /// queried.
  const PointDbRepository(
    this.fallbackRepository,
    this.database,
    this.logger,
  );

  /// The [database] is the local SQLite database where findings are saved and
  /// queried.
  @protected
  final Future<Database> database;
  @protected
  final Logger logger;

  /// The [fallbackRepository] is another source (typically remote) from which
  /// findings can be fetched if they aren't available in the local database.
  @protected
  final PointRepository fallbackRepository;

  @override
  Stream<Point> findOne(String id, [Stream? cancellationStream]) async* {
    final dbEntity = await findOneLocally(id);
    if (dbEntity != null) {
      yield dbEntity;
      return;
    }

    yield* findOneFallback(id, cancellationStream);
  }

  /// Retrieves a specific [PointDbEntity] by its [id] from the local database.
  @protected
  Future<PointDbEntity?> findOneLocally(String id) async {
    final db = await database;
    final queryResult = await db.query(
      PointDbEntity.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    final result = queryResult.map(PointDbEntity.fromJson);
    return result.isEmpty ? null : result.first;
  }

  /// Retrieves a specific [Point] by its [id] using the [fallbackRepository].
  @protected
  Stream<Point> findOneFallback(String id, [Stream? cancellation]) async* {
    final stream = fallbackRepository.findOne(id, cancellation);

    await for (final point in stream) {
      final entity = create(point);
      yield await saveOne(entity);
      logger.d('Inserted 1 item.');
    }
  }

  /// Saves the [entity] to the local database for future queries.
  @protected
  Future<PointDbEntity> saveOne(PointDbEntity entity) async {
    final db = await database;

    await db.insert(
      PointDbEntity.tableName,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return entity;
  }

  /// Create a [PointDbEntity] object using the [point] object as source.
  @protected
  PointDbEntity create(Point point) {
    return PointDbEntity(
      id: point.id,
      spot: point.spot,
      type: point.type,
      bodySide: point.bodySide,
      offsetX: point.offsetX,
      offsetY: point.offsetY,
      expireAt: DateTime.now().add(_pointLifespan),
    );
  }
}
