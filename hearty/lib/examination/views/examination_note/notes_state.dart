import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../generated/locale_keys.g.dart';
import '../../examination/index.dart';
import 'notes_processing_state.dart';

class NotesState {
  final String title;
  final String? notes;
  final String? from;
  final DateTime createdAt;
  final DateTime? modifiedAt;
  final int? age;
  final int? weight;
  final ExaminationDiseases diseases;
  final NotesProcessingState processingState;
  final TextEditingController titleController;
  final FocusNode titleFocusNode;

  NotesState()
      : title = LocaleKeys.Examination.tr(),
        notes = null,
        diseases = const ExaminationDiseases(),
        processingState = NotesProcessingState.ready,
        titleController = TextEditingController(
          text: LocaleKeys.Examination.tr(),
        ),
        createdAt = DateTime.now(),
        modifiedAt = null,
        from = null,
        weight = null,
        age = null,
        titleFocusNode = FocusNode();

  NotesState._({
    required this.title,
    this.notes,
    this.modifiedAt,
    this.from,
    this.age,
    this.weight,
    required this.diseases,
    required this.createdAt,
    required this.processingState,
    required this.titleController,
    required this.titleFocusNode,
  }) : super();

  factory NotesState.fromExamination(Examination examination) {
    return NotesState._(
      title: examination.title,
      notes: examination.notes,
      createdAt: examination.createdAt,
      modifiedAt: examination.modifiedAt,
      from: examination.from,
      diseases: examination.diseases,
      processingState: NotesProcessingState.ready,
      titleController: TextEditingController(text: examination.title),
      titleFocusNode: FocusNode(),
      age: examination.age,
      weight: examination.weight,
    );
  }

  NotesState copyWith({
    String? newTitle,
    String? newNotes,
    DateTime? newCreatedAt,
    DateTime? newModifiedAt,
    String? newFrom,
    ExaminationDiseases? newDiseases,
    NotesProcessingState? newSavingState,
    TextEditingController? newTitleController,
    FocusNode? newTitleFocusNode,
    int? age,
    int? weight,
  }) {
    return NotesState._(
      title: newTitle ?? title,
      notes: newNotes ?? notes,
      diseases: newDiseases ?? diseases,
      createdAt: newCreatedAt ?? createdAt,
      modifiedAt: newModifiedAt ?? modifiedAt,
      from: newFrom ?? from,
      processingState: newSavingState ?? processingState,
      titleController: newTitleController ?? titleController,
      titleFocusNode: newTitleFocusNode ?? titleFocusNode,
      age: age ?? this.age,
      weight: weight ?? this.weight,
    );
  }
}
