import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/disease.dart';
import '../entities/disease_status.dart';
import 'diseases.dart';

final diseasesRepositoryProvider = Provider.autoDispose<DiseasesRepository>(
  (ref) => DiseasesRepository(
    listOfHeartDiseases,
    listOfLungDiseases,
  ),
);

class DiseasesRepository {
  final List<Disease> _heartDiseases;
  final List<Disease> _lungDiseases;

  DiseasesRepository(this._heartDiseases, this._lungDiseases);

  Future<List<DiseaseStatus>> searchHeartDiseases(
    String search,
    List<DiseaseStatus> addedItems,
  ) {
    return findInList(_heartDiseases, search, addedItems);
  }

  Future<List<DiseaseStatus>> searchLungDiseases(
    String search,
    List<DiseaseStatus> addedItems,
  ) {
    return findInList(_lungDiseases, search, addedItems);
  }

  @visibleForTesting
  Future<List<DiseaseStatus>> findInList(
    List<Disease> source,
    String search,
    List<DiseaseStatus> addedItems,
  ) async {
    final results = List<DiseaseStatus>.empty(growable: true);
    final searchStr = search.toLowerCase();
    for (final disease in source) {
      final diseaseName = disease.name.toLowerCase();

      if (diseaseName.contains(searchStr)) {
        if (!addedItems
            .contains(DiseaseStatus(disease: disease, isSelected: true))) {
          results.add(DiseaseStatus(disease: disease));
        }
      }
    }
    return results;
  }
}
