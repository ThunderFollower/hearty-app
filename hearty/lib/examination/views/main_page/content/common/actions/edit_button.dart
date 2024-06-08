import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import 'edit_examination_controller_provider.dart';

class EditButton extends ConsumerWidget {
  const EditButton({
    super.key,
    required this.examinationId,
  });

  final String examinationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerProvider = editExaminationControllerProvider(examinationId);
    final controller = ref.watch(controllerProvider);

    return SlidableActionButton(
      icon: AppIcons.edit,
      onPressed: controller.onPressed,
    );
  }
}
