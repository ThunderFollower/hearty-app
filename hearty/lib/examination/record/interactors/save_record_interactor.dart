import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../asset/index.dart';
import '../body_side.dart';
import '../entities/record.dart';
import '../record_analysis_status.dart';
import '../record_service.dart';
import '../save_record_use_case.dart';

class SaveRecordInteractor implements SaveRecordUseCase {
  const SaveRecordInteractor(this.assetService, this.recordService);

  @protected
  final AssetService assetService;
  @protected
  final RecordService recordService;

  @override
  Stream<Record> execute({
    String? id,
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required File recordFile,
    Asset? asset,
    RecordAnalysisStatus? analysisStatus,
    Stream? cancellation,
  }) async* {
    final assetEntity = await assetService.save(
      assetFile: recordFile,
      asset: asset,
    );

    assert(assetEntity.id != null);
    final assetId = assetEntity.id!;
    yield* recordService.save(
      id: id,
      bodyPosition: bodyPosition,
      examinationPointId: examinationPointId,
      assetId: assetId,
      analysisStatus: analysisStatus,
    );
  }
}
