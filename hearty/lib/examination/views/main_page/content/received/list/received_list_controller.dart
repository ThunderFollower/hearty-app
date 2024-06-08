import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../../../config.dart';
import '../../../../../../utils/utils.dart';
import '../../../../../examination.dart';

final receivedListStateProvider = StateNotifierProvider.autoDispose<
    ReceivedListController, ReceivedListState>(
  (ref) => ReceivedListController(
    ref.watch(deleteExaminationProvider),
    ref,
    Logger(),
  ),
);

// TODO: Implement a controller them fit "screaming" architecture.
class ReceivedListController extends StateNotifier<ReceivedListState>
    with SubscriptionManager {
  ReceivedListController(
    this._deleteExamination,
    this._ref,
    this._logger,
  ) : super(ReceivedListState._(scrollController: ScrollController())) {
    _ref.onDispose(() {
      state.scrollController.removeListener(_onScroll);
      state.scrollController.dispose();
    });
    state.scrollController.addListener(_onScroll);
    _service = _ref.read(examinationsServiceProvider);
    refresh();

    final deletionSubscription = _service.deletionStream.listen(
      _didDeleteExamination,
    );
    addSubscription(deletionSubscription);
  }

  static final _debouncer = Debouncer();
  final DeleteExaminationUseCase _deleteExamination;
  late final ExaminationService _service;
  final Ref _ref;
  bool isLoading = true;

  /// The utility for logging actions and state changes in this class.
  final Logger _logger;

  @override
  void dispose() {
    cancelSubscriptions();
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
      _debouncer.debounce(_loadMore);
    }
  }

  Future<ExaminationList> load() => _service.find(
        page: state.currentPage,
        perPage: state.perPage,
        received: true,
      );

  Future<void> _loadMore() async {
    isLoading = true;
    state = state.copyWith(newIsLoadingMore: true);

    final examinationList = await load();

    state = state.copyWith(
      newCurrentPage: state.currentPage + 1,
      newExaminations:
          examinationList.examinations.union(state.examinations ?? {}),
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
      received: true,
    );

    state = state.copyWith(
      newExaminations:
          examinationList.examinations.union(state.examinations ?? {}),
      newHasMore: currentPage + 1 < examinationList.pages,
    );
    isLoading = false;
  }

  Future<void> refresh() => _refresh();

  Future<void> _refresh() async {
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
        'Cannot load a list of received examination.',
        error,
        stackTrace,
      );
    } finally {
      isLoading = false;
    }
  }

  bool _hasMorePages(ExaminationList examinationList) =>
      state.currentPage + 1 < examinationList.pages;

  Future<Examination> refreshOne(String id) async {
    final data = await _service.findOne(id).toList();

    if (data.isEmpty) {
      throw Exception('There is no examination.');
    }

    final exam = data.first;
    final examShort = ExaminationShort.fromExamination(exam);
    state.examinations?.remove(examShort);
    state.examinations?.add(examShort);
    state = state.copyWith(newExaminations: state.examinations);
    return exam;
  }

  Future<void> deleteOne(String id) async {
    state = state.copyWith(
      newExaminations: state.examinations?.where((e) => e.id != id).toSet(),
    );

    try {
      await _deleteExamination.execute(id);
    } catch (error, stackTrace) {
      _logger.e(
        'Cannot delete the received examination $id.',
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

class ReceivedListState {
  const ReceivedListState._({
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

  ReceivedListState copyWith({
    Set<ExaminationShort>? newExaminations,
    int? newCurrentPage,
    int? newPerPage,
    bool? newHasMore,
    bool? newIsLoadingMore,
  }) {
    return ReceivedListState._(
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
