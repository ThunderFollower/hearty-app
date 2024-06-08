import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../../disease/entities/disease_status.dart';
import '../../disease/fixture/diseases_repository.dart';
import '../../examination.dart';
import '../examination_note/config/examination_notes_state_provider.dart';

final searchDiseaseControllerProvider = StateNotifierProvider.autoDispose
    .family<SearchDiseaseController, SearchDiseaseState, OrganType>(
  (ref, type) {
    final diseases = type == OrganType.heart
        ? ref.read(examinationNotesStateProvider).diseases.heartDiseases
        : ref.read(examinationNotesStateProvider).diseases.lungDiseases;
    final searchDiseasesRepository = ref.read(diseasesRepositoryProvider);
    final router = ref.watch(routerProvider);
    return SearchDiseaseController(
      searchDiseasesRepository,
      type,
      router,
      diseases.map((e) => DiseaseStatus(disease: e, isSelected: true)).toList(),
    );
  },
);

class SearchDiseaseController extends StateNotifier<SearchDiseaseState> {
  SearchDiseaseController(
    this._searchDiseasesRepository,
    this._type,
    this._router,
    List<DiseaseStatus> diseases,
  ) : super(SearchDiseaseState._(addedList: diseases)) {
    // Gets all available diseases for selection.
    searchDiseases();
  }

  final OrganType _type;
  final DiseasesRepository _searchDiseasesRepository;
  final StackRouter _router;

  Future<void> searchDiseases([String searchString = '']) async {
    state = state.copyWith(
      searchString: searchString,
      searchList: await _getDiseasesList(searchString),
      addedList: state.addedList,
    );
  }

  Future<List<DiseaseStatus>> _getDiseasesList(String searchString) async {
    return _type == OrganType.heart
        ? await _searchHeartDiseases(searchString)
        : await _searchLungDiseases(searchString);
  }

  Future<List<DiseaseStatus>> _searchHeartDiseases(String searchString) {
    return _searchDiseasesRepository.searchHeartDiseases(
      searchString,
      state.addedList,
    );
  }

  Future<List<DiseaseStatus>> _searchLungDiseases(String searchString) {
    return _searchDiseasesRepository.searchLungDiseases(
      searchString,
      state.addedList,
    );
  }

  Future<void> selectDisease(DiseaseStatus disease) async {
    final newAddedList = List<DiseaseStatus>.of(state.addedList);
    state.addedList.contains(disease)
        ? newAddedList.remove(disease)
        : newAddedList.add(disease.copyWith(isSelected: true));
    state = state.copyWith(addedList: newAddedList);

    final newSearchList = await _getDiseasesList(state.searchString);
    state = state.copyWith(searchList: newSearchList);
  }

  void openPreviousPage() {
    _router.pop();
  }

  void completeSelection() {
    _router.pop(state.addedList.map((e) => e.disease).toList());
  }
}

class SearchDiseaseState {
  String searchString;
  List<DiseaseStatus> searchList;
  List<DiseaseStatus> addedList;

  List<DiseaseStatus> getDisplayList() {
    final displayList = searchList + addedList;
    displayList.sort((d1, d2) {
      return d1.disease.name.compareTo(d2.disease.name);
    });
    return displayList;
  }

  SearchDiseaseState._({
    this.searchString = '',
    this.searchList = const [],
    this.addedList = const [],
  });

  SearchDiseaseState copyWith({
    String? searchString,
    List<DiseaseStatus>? searchList,
    List<DiseaseStatus>? addedList,
  }) {
    return SearchDiseaseState._(
      searchString: searchString ?? this.searchString,
      searchList: searchList ?? this.searchList,
      addedList: addedList ?? this.addedList,
    );
  }
}
