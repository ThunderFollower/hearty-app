import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import '../../../../../../generated/locale_keys.g.dart';
import '../../../../../record/entities/record_point.dart';
import 'new_record_controller_provider.dart';

class NewRecordButton extends ConsumerWidget {
  const NewRecordButton({
    required this.recordPoint,
    this.enabled = true,
  });

  final RecordPoint recordPoint;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(newRecordControllerProvider);

    final content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIcon(context),
        const SizedBox(width: lowestIndent),
        _buildLabel(context),
      ],
    );

    return RoundCornersButton(
      enabled: enabled,
      onTap: controller.onRecord,
      child: content,
    );
  }

  Widget _buildLabel(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.primaryContainer;
    final textStyle = theme.textTheme.titleLarge?.copyWith(color: textColor);

    return Text(LocaleKeys.Go_to_Record.tr(), style: textStyle);
  }

  Widget _buildIcon(BuildContext context) =>
      Icon(AppIcons.rec, color: Theme.of(context).colorScheme.primaryContainer);
}
