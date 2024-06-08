import 'dart:async';

import 'body_side.dart';
import 'entities/record.dart';
import 'record_analysis_status.dart';

abstract class RecordService {
  /// Stream emitting the IDs of deleted records.
  Stream<String> get deletion;

  /// Stream emitting created records.
  Stream<Record> get creation;

  /// Save the audio record to a remote storage.
  Stream<Record> save({
    required String? id,
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    RecordAnalysisStatus? analysisStatus,
    Stream? cancellation,
  });

  /// Delete the audio record to by its [id].
  Future<void> delete(String id, [Stream? cancellation]);

  /// Clear the record cache by its [id].
  Future<void> invalidate(String id);

  /// Retrieves the audio record by its [id].
  Stream<Record> findOne(String id, [Stream? cancellation]);

  /// Analyses for the audio record [id] and emits an intermediate record.
  Stream<Record> analyse(String id, [Stream? cancellation]);

  /// Retrieves analysis status for the audio record [id].
  Stream<RecordAnalysisStatus> getAnalysisStatus(
    String id, [
    Stream? cancellation,
  ]);
}
