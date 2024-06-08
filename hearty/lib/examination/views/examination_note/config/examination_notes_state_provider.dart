import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views.dart';
import '../../examination/index.dart';
import '../../examination_root/examination_list_controller.dart';
import '../../main_page/content/received/list/received_list_controller.dart';
import '../examination_notes_controller.dart';
import '../notes_state.dart';

/// Provides [ExaminationNotesController] with [NotesState]
final examinationNotesStateProvider =
    StateNotifierProvider.autoDispose<ExaminationNotesController, NotesState>(
  (ref) {
    final state = ref.watch(examinationStateProvider);
    final router = ref.watch(routerProvider);
    final examinationController = ref.watch(examinationStateProvider.notifier);
    final receivedListController = ref.watch(
      receivedListStateProvider.notifier,
    );
    final examListController = ref.watch(examinationListController.notifier);

    return ExaminationNotesController(
      state.examination,
      router,
      examinationController,
      receivedListController,
      examListController,
    );
  },
);
