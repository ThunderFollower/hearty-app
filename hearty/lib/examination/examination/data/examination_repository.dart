import '../entities/index.dart';

abstract class ExaminationRepository {
  Future<void> delete(String id, [Stream<void>? cancellation]);

  Future<ExaminationList> find({
    required int offset,
    required int limit,
    bool? received,
    bool? mine,
    Stream<void>? cancellation,
  });

  Future<Examination> findOne(String id, [Stream<void>? cancellation]);

  Future<Examination> create(
    Examination prototype, [
    Stream<void>? cancellation,
  ]);

  Future<Examination> update(
    String id, {
    required Examination examination,
    Stream<void>? cancellation,
  });
}
