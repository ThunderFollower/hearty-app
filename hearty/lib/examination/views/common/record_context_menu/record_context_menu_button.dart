import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/views/index.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../examination.dart';
import '../../examination/body/modal_menu/modal_menu.dart';
import 'providers.dart';
import 'record_context_menu_controller.dart';

class RecordContextMenuButton extends ConsumerWidget {
  const RecordContextMenuButton({
    super.key,
    required this.recordId,
    required this.spot,
    this.onDelete,
    this.onRecordAgain,
  });

  final String recordId;
  final Spot spot;
  final VoidCallback? onDelete;
  final VoidCallback? onRecordAgain;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final provider = recordContextMenuControllerProvider(recordId);
    final controller = ref.watch(provider);

    return IconButton(
      onPressed: () => _onMenuPressed(context, _buildMenu(controller)),
      icon: Icon(AppIcons.actions, color: theme.colorScheme.onPrimary),
      iconSize: _iconSize,
    );
  }

  Widget _buildMenu(RecordContextMenuController controller) {
    final labels = [
      LocaleKeys.Record_Again.tr(),
      LocaleKeys.Delete_Record.tr(),
    ];

    final actions = [
      () => _reRecord(controller),
      () => _delete(controller),
    ];

    return ModalMenu(labels: labels, actions: actions);
  }

  Future<T?> _onMenuPressed<T>(
    BuildContext context,
    Widget modalMenu,
  ) {
    return showModalDialog<T>(context: context, child: modalMenu);
  }

  Future<void> _delete(RecordContextMenuController controller) async {
    final result = await controller.onDelete();
    if (result == true) onDelete?.call();
  }

  Future<void> _reRecord(RecordContextMenuController controller) async {
    final result = await controller.onRecordAgain();
    if (result == true) onRecordAgain?.call();
  }
}

const _iconSize = 25.0;
