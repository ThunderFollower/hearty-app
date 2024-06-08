import 'dart:io';

import '../asset/index.dart';
import 'body_side.dart';
import 'entities/record.dart';
import 'record_analysis_status.dart';

abstract class SaveRecordUseCase {
  Stream<Record> execute({
    required String? id,
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required File recordFile,
    Asset? asset,
    RecordAnalysisStatus? analysisStatus,
    Stream? cancellation,
  });
}
