import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../main_page/content/mine/empty/my_empty_list.dart';
import '../../examination_list_controller.dart';
import 'filled_list/examinations.dart';

class ExaminationList extends ConsumerWidget {
  const ExaminationList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examinations = ref
        .watch(examinationListController.select((state) => state.examinations));

    if (examinations == null) {
      return const CircularProgressIndicator(color: Colors.pink);
    }

    return Expanded(
      child:
          examinations.isNotEmpty ? const Examinations() : const MyEmptyList(),
    );
  }
}
