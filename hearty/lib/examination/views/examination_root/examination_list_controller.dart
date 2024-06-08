import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../config.dart';
import '../../../../utils/utils.dart';
import '../../examination.dart';

final examinationListController = StateNotifierProvider.autoDispose<
    ExaminationListController, ExaminationListState>(
  (ref) => ExaminationListController(
    ref.watch(deleteExaminationProvider),
    ref.watch(examinationsServiceProvider),
    Logger(),
  ),
);

class ExaminationListController extends StateNotifier<ExaminationListState>
    with SubscriptionManager {
  ExaminationListController(
    this._deleteExamination,
    this._service,
    this._logger,
  ) : super(ExaminationListState._(scrollController: ScrollController())) {
    state.scrollController.addListener(_onScroll);
    refresh();
    _service.deletionStream.listen(_didDeleteExamination).addToList(this);
  }

  final DeleteExaminationUseCase _deleteExamination;
  final ExaminationService _service;

  bool isLoading = true;

  /// The utility for logging actions and state changes in this class.
  final Logger _logger;

  @override
  void dispose() {
    cancelSubscriptions();
    state.scrollController.removeListener(_onScroll);
    state.scrollController.dispose();
    super.dispose();
  }

  void _didDeleteExamination(String id) {
    // Mind the gap! I mean the asynchronous gap.
    if (!mounted) return;

    final examinations = state.examinations
        ?.where(
          (event) => event.id != id,
        )
        .toSet();
    final page = (examinations?.length ?? 0) ~/ state.perPage + 1;

    state = state.copyWith(
      newExaminations: examinations,
      newCurrentPage: page,
    );

    if (state.hasMore) {
      _loadOne();
    }
  }

  void _onScroll() {
    if (state.hasMore &&
        !isLoading &&
        state.scrollController.position.pixels >=
            state.scrollController.position.maxScrollExtent) {
      _loadMore();
    }
  }

  Future<ExaminationList> load() => _service.find(
        page: state.currentPage,
        perPage: state.perPage,
        mine: true,
      );

  Future<void> _loadMore() async {
    isLoading = true;
    state = state.copyWith(newIsLoadingMore: true);

    final examinationList = await load();

    state = state.copyWith(
      newCurrentPage: state.currentPage + 1,
      newExaminations: state.examinations?.union(examinationList.examinations),
      newPerPage: examinationList.perPage,
      newIsLoadingMore: false,
      newHasMore: _hasMorePages(examinationList),
    );
    isLoading = false;
  }

  Future<void> _loadOne() async {
    isLoading = true;

    final currentPage = state.examinations!.length;
    final examinationList = await _service.find(
      page: currentPage,
      perPage: 1,
      mine: true,
    );

    state = state.copyWith(
      newExaminations: state.examinations?.union(examinationList.examinations),
      newHasMore: currentPage + 1 < examinationList.pages,
    );
    isLoading = false;
  }

  Future<void> refresh() => _refresh();

  Future<void> _refresh() async {
    // Mind the gap! I mean the asynchronous gap.
    if (!mounted) return;
    state = state.copyWith(newCurrentPage: 0);

    try {
      final examinationList = await load();
      state = state.copyWith(
        newCurrentPage: state.currentPage + 1,
        newExaminations: examinationList.examinations.toSet(),
        newPerPage: examinationList.perPage,
        newIsLoadingMore: false,
        newHasMore: _hasMorePages(examinationList),
      );
    } catch (error, stackTrace) {
      _logger.e(
        'Cannot load a list of examination.',
        error,
        stackTrace,
      );
    } finally {
      isLoading = false;
    }
  }

  bool _hasMorePages(ExaminationList examinationList) =>
      state.currentPage + 1 < examinationList.pages;

  Stream<Examination> refreshOneAsStream(String id) async* {
    final stream = _service
        .findOne(id)
        .switchIfEmpty(Stream.error(Exception('There is no examination.')));
    await for (final examination in stream) {
      final examShort = ExaminationShort.fromExamination(examination);
      final wasRemoved = state.examinations?.remove(examShort);
      if (wasRemoved == true) {
        state.examinations?.add(examShort);
        state = state.copyWith(newExaminations: state.examinations);
      }
      yield examination;
    }
  }

  void handleRefreshedExaminationShort(ExaminationShort examinationShort) {
    state.examinations?.add(examinationShort);
    state = state.copyWith(newExaminations: state.examinations);
  }

  Future<void> deleteOne(String id) async {
    state = state.copyWith(
      newExaminations: state.examinations?.where((e) => e.id != id).toSet(),
    );

    try {
      await _deleteExamination.execute(id);
    } catch (error, stackTrace) {
      _logger.e(
        'Cannot delete the examination $id.',
        error,
        stackTrace,
      );
      await _refresh();
    }
  }

  Future<Examination> save(Examination examination) async {
    final exam = await _service.save(examination);
    await _refresh();
    return exam;
  }
}

class ExaminationListState {
  const ExaminationListState._({
    this.examinations,
    this.currentPage = 0,
    this.perPage = Config.examinationsPerPage,
    this.hasMore = true,
    this.isLoadingMore = true,
    required this.scrollController,
  });

  final Set<ExaminationShort>? examinations;
  final int currentPage;
  final int perPage;
  final bool hasMore;
  final bool isLoadingMore;
  final ScrollController scrollController;

  ExaminationListState copyWith({
    Set<ExaminationShort>? newExaminations,
    int? newCurrentPage,
    int? newPerPage,
    bool? newHasMore,
    bool? newIsLoadingMore,
  }) {
    return ExaminationListState._(
      examinations: newExaminations ?? examinations,
      currentPage: newCurrentPage ?? currentPage,
      perPage: newPerPage ?? perPage,
      hasMore: newHasMore ?? hasMore,
      isLoadingMore: newIsLoadingMore ?? isLoadingMore,
      scrollController: scrollController,
    );
  }

  bool get hasExaminations => examinations?.isNotEmpty ?? false;
}
