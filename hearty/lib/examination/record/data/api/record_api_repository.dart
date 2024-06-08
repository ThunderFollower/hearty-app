import '../../../../core/core.dart';
import '../../body_side.dart';
import '../../entities/record.dart';
import '../../record_analysis_status.dart';
import '../record_repository.dart';
import 'constants.dart';
import 'dto/dto.dart';

class RecordApiRepository implements RecordRepository {
  const RecordApiRepository(this._dataSource, this._cancelable);

  final HttpDataSource _dataSource;
  final Cancelable _cancelable;

  @override
  Stream<Record> create({
    required BodyPosition bodyPosition,
    required String examinationPointId,
    required String assetId,
    Stream? cancellation,
  }) async* {
    try {
      final body = CreateRecordDto(
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
      );

      final response = await _dataSource.post(
        pathToRecords,
        body: body,
        cancelable: _cancelable,
        cancellationStream: cancellation,
        deserializer: AudioRecordResponseDto.fromJson,
      );

      yield _mapToRecord(response);
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  @override
  Stream<Record> findOne(String id, [Stream? cancellation]) async* {
    try {
      final response = await _dataSource.get(
        pathToRecord(id),
        cancelable: _cancelable,
        cancellationStream: cancellation,
        deserializer: AudioRecordResponseDto.fromJson,
      );

      yield _mapToRecord(response);
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  @override
  Stream<Record> update(
    String id, {
    BodyPosition? bodyPosition,
    String? examinationPointId,
    String? assetId,
    Stream? cancellation,
    RecordAnalysisStatus? analysisStatus,
  }) async* {
    try {
      final body = UpdateRecordDto(
        bodyPosition: bodyPosition,
        examinationPointId: examinationPointId,
        assetId: assetId,
        analysisStatus: analysisStatus,
      );

      final response = await _dataSource.patch(
        pathToRecord(id),
        headers: AcceptDto(accept: mimeTypeApplicationJson),
        body: body,
        cancelable: _cancelable,
        cancellationStream: cancellation,
        deserializer: AudioRecordResponseDto.fromJson,
      );

      yield _mapToRecord(response);
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  @override
  Future<void> delete(String id, [Stream? cancellation]) async {
    try {
      await _dataSource.delete<void>(
        pathToRecord(id),
        cancelable: _cancelable,
        cancellationStream: cancellation,
      );
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  @override
  Stream<Record> analyseAudioRecord(
    String recordId, [
    Stream? cancellation,
  ]) async* {
    try {
      await _dataSource.post(
        pathToAcquireRecordQualityStatus(recordId),
        cancelable: _cancelable,
        cancellationStream: cancellation,
      );

      yield* const Stream.empty();
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  @override
  Stream<AudioRecordAnalysisResponseDto> determineRecordAnalysis(
    String recordId, [
    Stream? cancellation,
  ]) async* {
    try {
      final response = await _dataSource.get<AudioRecordAnalysisResponseDto>(
        pathToAcquireRecordQualityStatus(recordId),
        deserializer: AudioRecordAnalysisResponseDto.fromJson,
        cancelable: _cancelable,
        cancellationStream: cancellation,
      );
      yield response;
    } on CanceledException catch (_) {
      // This is an expected behavior when the request is canceled.
    }
  }

  Record _mapToRecord(AudioRecordResponseDto dto) => Record(
        id: dto.id,
        examinationPointId: dto.examinationPointId,
        bodyPosition: dto.bodyPosition,
        asset: dto.asset,
        assetId: dto.assetId,
        analysisStatus: dto.analysisStatus,
        spot: dto.spot,
        examinationId: dto.examinationId,
      );

  @override
  Future<void> invalidate(String id) {
    throw UnimplementedError();
  }
}
