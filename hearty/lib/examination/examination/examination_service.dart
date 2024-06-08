import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import 'data/data.dart';
import 'entities/index.dart';

final examinationsServiceProvider =
    Provider.autoDispose<ExaminationService>((ref) {
  final examinationService = ExaminationService(ref);
  ref.onDispose(examinationService.dispose);
  return examinationService;
});

class ExaminationService {
  final Ref _ref;
  late final ExaminationRepository _examinationRepository;

  ExaminationService(this._ref) {
    _examinationRepository = _ref.read(examinationProvider);
  }

  final _deletionStream = StreamController<String>.broadcast();

  @protected
  final examinationState = BehaviorSubject<Examination>();

  /// Listen to deletion events.
  Stream<String> get deletionStream => _deletionStream.stream;

  void dispose() {
    _deletionStream.close();
    examinationState.close();
  }

  Future<ExaminationList> find({
    required int page,
    required int perPage,
    bool? received,
    bool? mine,
    Stream? cancellation,
  }) =>
      _examinationRepository.find(
        offset: page * perPage,
        limit: perPage,
        received: received,
        mine: mine,
        cancellation: cancellation,
      );

  Stream<Examination> findOne(String id, [Stream? cancellation]) =>
      MergeStream([
        findOneFromState(id, cancellation),
        findOneFromRepository(id, cancellation),
      ]).distinct();

  @protected
  Stream<Examination> findOneFromState(String id, [Stream? cancellation]) =>
      examinationState
          .takeUntil(cancellation ?? NeverStream())
          .where((examination) => examination.id == id);

  @protected
  Stream<Examination> findOneFromRepository(
    String id, [
    Stream? cancellation,
  ]) async* {
    final examination = await _examinationRepository.findOne(id, cancellation);
    examinationState.add(examination);
    yield examination;
  }

  Future<void> deleteOne(String id, [Stream? cancellation]) async {
    await _examinationRepository.delete(id, cancellation);
    _deletionStream.sink.add(id);
  }

  Future<Examination> save(
    Examination examination, [
    Stream? cancellation,
  ]) async {
    late Examination result;
    final id = examination.id;
    if (id == null) {
      result = await _examinationRepository.create(examination, cancellation);
    } else {
      result = await _examinationRepository.update(
        id,
        examination: examination,
        cancellation: cancellation,
      );
    }

    examinationState.add(result);
    return result;
  }
}
