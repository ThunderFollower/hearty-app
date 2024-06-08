import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

import '../../../cardio_findings/data/db/entities/relations/cardio_finding_relations_db_entity.dart';
import '../../body_side.dart';
import '../../entities/record.dart';
import '../../record_analysis_status.dart';
import '../api/dto/audio_record_analysis_response_dto/audio_record_analysis_response_dto.dart';
import '../record_repository.dart';

class RecordDbRepository implements RecordRepository {
  /// Constructs a [RecordDbRepository].
  ///
  /// The [fallbackRepository] is another source (typically remote) from which
  /// findings can be fetched if they aren't available in the local database.
  ///
  /// The [database] is the local SQLite database where findings are saved and queried.
  RecordDbRepository(
    this.fallbackRepository,
    this.database,
    this.logger,
  );

  @protected
  final Future<Database> database;
  @protected
  final RecordRepository fallbackRepository;
  @protected
  final Logger logger;

  @override
  Stream<Record> analyseAudioRecord(
    String recordId, [
    Stream? cancellation,
  ]) async* {
    final recordStream = findOne(recordId, cancellation).take(1);
    await for (final record in recordStream) {
      yield record.copyWith(analysisStatus: RecordAnalysisStatus.none);
    }

    yield* fallbackRepository.analyseAudioRecord(recordId, cancellation);
  }

  @override
  Stream<Record> create({
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    Stream? cancellation,
  }) =>
      fallbackRepository.create(
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
        cancellation: cancellation,
      );

  @override
  Future<void> delete(String id, [Stream? cancellation]) async {
    await fallbackRepository.delete(id, cancellation);
    final count = await _deleteRelations(id);
    if (count > 0) logger.v('Deleted $count items.');
  }

  Future<int> _deleteRelations(String id) async {
    final db = await database;

    return db.delete(
      CardioFindingRelationsDbEntity.tableName,
      where: 'recordId = ?',
      whereArgs: [id],
    );
  }

  @override
  Stream<AudioRecordAnalysisResponseDto> determineRecordAnalysis(
    String recordId, [
    Stream? cancellation,
  ]) =>
      fallbackRepository.determineRecordAnalysis(recordId, cancellation);

  @override
  Stream<Record> findOne(String id, [Stream? cancellation]) =>
      fallbackRepository.findOne(id, cancellation);

  @override
  Stream<Record> update(
    String id, {
    BodyPosition? bodyPosition,
    String? examinationPointId,
    String? assetId,
    Stream? cancellation,
    RecordAnalysisStatus? analysisStatus,
  }) =>
      fallbackRepository.update(
        id,
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
        cancellation: cancellation,
        analysisStatus: analysisStatus,
      );

  @override
  Future<void> invalidate(String id) async {
    final count = await _deleteRelations(id);
    if (count > 0) logger.v('Deleted $count items.');
  }
}
