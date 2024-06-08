import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/views/locator/app_locator.dart';
import '../../../core/views/theme/app_icons.dart';
import '../../../core/views/theme/indentation_constants.dart';
import '../../../generated/locale_keys.g.dart';
import '../../record/organ_type.dart';
import 'search_disease_controller.dart';

class SearchDiseaseAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const SearchDiseaseAppBar({
    required this.title,
    required this.type,
  });

  final String title;
  final OrganType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stateProvider = searchDiseaseControllerProvider(type);
    final controller = ref.watch(stateProvider.notifier);

    final theme = Theme.of(context);
    final titleTextStyle = theme.textTheme.labelLarge;
    final backgroundColor = theme.colorScheme.primaryContainer;

    final titleText = Text(title, style: titleTextStyle);
    final fittedBox = FittedBox(fit: BoxFit.scaleDown, child: titleText);

    return AppBar(
      leading: _buildLeading(controller),
      centerTitle: true,
      title: fittedBox,
      elevation: 0,
      backgroundColor: backgroundColor,
      actions: [_buildActionButton(controller, theme)],
    );
  }

  Widget _buildLeading(SearchDiseaseController controller) {
    const appLocator = AppLocator(
      id: 'back_button',
      child: Icon(AppIcons.back),
    );

    return IconButton(onPressed: controller.openPreviousPage, icon: appLocator);
  }

  Widget _buildActionButton(
    SearchDiseaseController controller,
    ThemeData theme,
  ) {
    final textColor = theme.colorScheme.onSurface;
    final textStyle = theme.textTheme.bodyLarge?.copyWith(color: textColor);

    final text = Text(LocaleKeys.Done.tr(), style: textStyle);
    final fittedBox = FittedBox(fit: BoxFit.scaleDown, child: text);

    return IconButton(
      padding: _actionButtonPadding,
      onPressed: controller.completeSelection,
      iconSize: veryHighIndent,
      icon: fittedBox,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

const _actionButtonPadding = EdgeInsets.only(right: middleIndent);
