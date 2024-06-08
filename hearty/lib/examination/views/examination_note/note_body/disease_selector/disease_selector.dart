import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../app_router.gr.dart';
import '../../../../../core/views/theme/index.dart';
import '../../../../examination.dart';
import '../../config/examination_notes_state_provider.dart';
import '../disease_element/section/section_name_with_add.dart';
import 'removable_chip/removable_chip.dart';

class DiseaseSelector extends ConsumerWidget {
  const DiseaseSelector({
    super.key,
    required this.title,
    required this.diseases,
    required this.type,
  });

  final String title;
  final List<Disease> diseases;
  final OrganType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(examinationNotesStateProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionNameWithAdd(
          title: title,
          onTap: () async {
            final result = await context.router.push<List<Disease>?>(
              SearchDiseaseRoute(
                pageTitle: title,
                type: type,
              ),
            );
            if (result != null) controller.updateDiseases(type, result);
          },
        ),
        const SizedBox(height: aboveLowestIndent),
        Wrap(
          spacing: 8,
          children: diseases
              .map(
                (item) => RemovableChip(
                  deleteChip: (disease) => controller.removeDisease(type, item),
                  chipLabel: item.name,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
