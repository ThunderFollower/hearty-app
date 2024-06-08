import 'record_analysis_status.dart';

abstract class DetermineRecordAnalysisUseCase {
  Stream<RecordAnalysisStatus> execute(
    String examinationId,
    String recordId, [
    Stream? cancellation,
  ]);
}
