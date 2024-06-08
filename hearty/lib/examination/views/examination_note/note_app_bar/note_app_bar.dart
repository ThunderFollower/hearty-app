import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../config/examination_notes_state_provider.dart';

/// Encapsulates visual logic of the top bar of the examination notes pages.
class NoteAppBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Create a new [NoteAppBar] that represents a visual logic of the top bar
  /// of the examination notes pages.
  const NoteAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(examinationNotesStateProvider.notifier);

    const icon = Icon(AppIcons.close);
    const appLocator = AppLocator(
      id: _buttonIdentifier,
      child: icon,
    );
    final leading = IconButton(
      onPressed: controller.navigateBack,
      icon: appLocator,
    );
    final text = Text(LocaleKeys.Information.tr());

    return AppBar(
      // TODO: [SV0-382] Add a standard close button widget
      leading: leading,
      title: text,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}

const _buttonIdentifier = 'close_button';
