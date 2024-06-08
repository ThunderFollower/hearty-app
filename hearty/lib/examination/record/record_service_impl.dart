import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'body_side.dart';
import 'data/data.dart';
import 'entities/record.dart';
import 'record_analysis_status.dart';
import 'record_service.dart';

class RecordServiceImpl implements RecordService {
  RecordServiceImpl(this._repository);

  final RecordRepository _repository;

  @protected
  final deletionState = StreamController<String>.broadcast();

  /// Stream emitting the IDs of deleted records.
  @override
  Stream<String> get deletion => deletionState.stream;

  @protected
  final recordState = BehaviorSubject<Record>();

  @protected
  final creationState = StreamController<Record>.broadcast();

  /// Stream emitting created records.
  @override
  Stream<Record> get creation => creationState.stream;

  void dispose() {
    deletionState.close();
    recordState.close();
    creationState.close();
  }

  /// Save the audio record to a remote storage.
  @override
  Stream<Record> save({
    required String? id,
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    RecordAnalysisStatus? analysisStatus,
    Stream? cancellation,
  }) async* {
    final stream = saveImpl(
      id: id,
      bodyPosition: bodyPosition,
      examinationPointId: examinationPointId,
      assetId: assetId,
      analysisStatus: analysisStatus,
    ).distinct();

    await for (final record in stream) {
      creationState.sink.add(record);
      recordState.sink.add(record);
      yield record;
    }
  }

  @protected
  Stream<Record> saveImpl({
    required String? id,
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    RecordAnalysisStatus? analysisStatus,
    Stream? cancellation,
  }) async* {
    if (id == null) {
      yield* _repository.create(
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
        cancellation: cancellation,
      );
    } else {
      yield* _repository.update(
        id,
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
        cancellation: cancellation,
        analysisStatus: analysisStatus,
      );
    }
  }

  /// Delete the audio record to by its [id].
  @override
  Future<void> delete(String id, [Stream? cancellation]) async {
    await _repository.delete(id, cancellation);
    deletionState.sink.add(id);
  }

  /// Retrieves the audio record by its [id].
  @override
  Stream<Record> findOne(String id, [Stream? cancellation]) {
    return MergeStream([
      findOneFromState(id),
      findOneFromRepository(id, cancellation),
    ]).distinct();
  }

  @protected
  Stream<Record> findOneFromState(String id) =>
      recordState.stream.where((event) => event.id == id);

  @protected
  Stream<Record> findOneFromRepository(String id, [Stream? cancellation]) =>
      _repository.findOne(id, cancellation).doOnData(recordState.sink.add);

  /// Analyses for the audio record [id].
  @override
  Stream<Record> analyse(String id, [Stream? cancellation]) =>
      _repository.analyseAudioRecord(id, cancellation).doOnData(_handleRecord);

  void _handleRecord(Record record) => recordState.add(record);

  /// Retrieves analysis status for the audio record [id].
  @override
  Stream<RecordAnalysisStatus> getAnalysisStatus(
    String id, [
    Stream? cancellation,
  ]) =>
      _repository
          .determineRecordAnalysis(id, cancellation)
          .map((data) => data.analysis);

  @override
  Future<void> invalidate(String id) => _repository.invalidate(id);
}
