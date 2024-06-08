import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import '../examination/index.dart';
import 'config/examination_notes_state_provider.dart';
import 'note_app_bar/note_app_bar.dart';

import 'note_body/notes_body.dart';

@RoutePage()
class ExaminationNotesPage extends ConsumerWidget {
  const ExaminationNotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examination = ref.watch(
      examinationStateProvider.select((state) => state.examination),
    );
    final controller = ref.watch(examinationNotesStateProvider.notifier);

    final body = examination.when(
      data: (_) => const NotesBody(),
      loading: () => const Loader(),
      error: (_, __) => Text(LocaleKeys.Something_went_wrong.tr()),
    );

    final scaffold = AppScaffold(appBar: const NoteAppBar(), body: body);
    final page = FocusTarget(child: scaffold);
    final dismissible = Dismissible(
      confirmDismiss: (_) => controller.isDismissingConfirmed(),
      onDismissed: (_) => controller.dismiss(),
      direction: DismissDirection.down,
      key: const Key('ExaminationNotesPage'),
      child: page,
    );

    return PrimaryContainerTheme(child: dismissible);
  }
}
