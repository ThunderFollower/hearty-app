import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import '../../examination.dart';
import 'search_disease_app_bar.dart';
import 'search_disease_controller.dart';
import 'selectable_chip/selectable_chip.dart';

// TODO: [STT-1626] Avoid business logic in the SearchDiseasePage class
// SearchDiseasePage should not include business and presentation logic
// (CONTRIBUTING 9.1) like `context.router.pop();`
@RoutePage<List<Disease>>()
class SearchDiseasePage extends ConsumerWidget {
  const SearchDiseasePage({
    super.key,
    required this.pageTitle,
    required this.type,
  });

  final String pageTitle;
  final OrganType type;

  // TODO: [STT-1627] SearchDiseasePage.build one level of abstraction
  // SearchDiseasePage.build method should only be one
  // level of abstraction
  // (CONTRIBUTING 5.8)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = searchDiseaseControllerProvider(type);
    final state = ref.watch(stateProvider);
    final controller = ref.read(stateProvider.notifier);
    final theme = Theme.of(context);
    final fillColor = theme.colorScheme.primary;
    final backgroundColor = theme.colorScheme.primaryContainer;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: AppScaffold(
        backgroundColor: backgroundColor,
        appBar: SearchDiseaseAppBar(title: pageTitle, type: type),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClearableTextInputField(
                  hintText: LocaleKeys.Search.tr(),
                  fillColor: fillColor,
                  onChanged: controller.searchDiseases,
                  filled: !FocusScope.of(context).hasFocus,
                  autoFocus: true,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: state
                      .getDisplayList()
                      .map(
                        (diseaseStatus) => SelectableChip(
                          onTap: (_) => controller.selectDisease(diseaseStatus),
                          chipLabel: diseaseStatus.disease.name,
                          isSelected: diseaseStatus.isSelected,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
