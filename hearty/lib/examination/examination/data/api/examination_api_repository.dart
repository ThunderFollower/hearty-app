import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';
import '../../../examination.dart';
import '../examination_repository.dart';
import 'dto/dto.dart';

const _prefix = '/examinations';
String _resolveEntity(String id) => '$_prefix/$id';

class ExaminationApiRepository implements ExaminationRepository {
  const ExaminationApiRepository(this.dataSource);

  /// An HTTP data source for accessing the private API.
  /// This is used to make API requests.
  @protected
  final HttpDataSource dataSource;

  @override
  Future<void> delete(String id, [Stream<void>? cancellation]) =>
      dataSource.delete(
        _resolveEntity(id),
        cancellationStream: cancellation,
      );

  @override
  Future<ExaminationList> find({
    required int offset,
    required int limit,
    bool? received,
    bool? mine,
    Stream<void>? cancellation,
  }) async {
    final queryParameters = FindExaminationsQueryDto(
      offset: offset,
      limit: limit,
      received: received,
      mine: mine,
    );

    return dataSource.get(
      _prefix,
      queryParameters: queryParameters,
      cancellationStream: cancellation,
      deserializer: ExaminationList.fromJson,
    );
  }

  @override
  Future<Examination> findOne(String id, [Stream<void>? cancellation]) =>
      dataSource.get(
        _resolveEntity(id),
        cancellationStream: cancellation,
        deserializer: Examination.fromJson,
      );

  @override
  Future<Examination> create(
    Examination prototype, [
    Stream<void>? cancellation,
  ]) {
    return dataSource.post(
      _prefix,
      body: CreateExaminationDto(ensureUtcDates(prototype)),
      cancellationStream: cancellation,
      deserializer: Examination.fromJson,
    );
  }

  @protected
  Examination ensureUtcDates(Examination examination) => examination.copyWith(
        createdAt: examination.createdAt.toUtc(),
        modifiedAt: examination.modifiedAt?.toUtc(),
      );

  @override
  Future<Examination> update(
    String id, {
    required Examination examination,
    Stream<void>? cancellation,
  }) {
    return dataSource.patch(
      _resolveEntity(id),
      body: UpdateExaminationDto(ensureUtcDates(examination)),
      cancellationStream: cancellation,
      deserializer: Examination.fromJson,
    );
  }
}
