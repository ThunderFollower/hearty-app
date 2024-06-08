import '../body_side.dart';
import '../entities/record.dart';
import '../record_analysis_status.dart';
import 'api/dto/dto.dart';

abstract class RecordRepository {
  Stream<Record> create({
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    Stream? cancellation,
  });

  Stream<Record> findOne(String id, [Stream? cancellation]);

  Stream<Record> update(
    String id, {
    BodyPosition? bodyPosition,
    String? examinationPointId,
    String? assetId,
    Stream? cancellation,
    RecordAnalysisStatus? analysisStatus,
  });

  Future<void> delete(String id, [Stream? cancellation]);

  Stream<Record> analyseAudioRecord(String recordId, [Stream? cancellation]);

  Stream<AudioRecordAnalysisResponseDto> determineRecordAnalysis(
    String recordId, [
    Stream? cancellation,
  ]);

  Future<void> invalidate(String id);
}
