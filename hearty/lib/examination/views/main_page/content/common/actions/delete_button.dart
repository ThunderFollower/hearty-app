import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/views.dart';
import 'delete_examination_controller_provider.dart';

class DeleteButton extends ConsumerWidget {
  const DeleteButton({
    super.key,
    required this.examinationId,
  });

  final String examinationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controllerProvider =
        deleteExaminationControllerProvider(examinationId);
    final controller = ref.watch(controllerProvider);

    return SlidableActionButton(
      icon: AppIcons.delete,
      onPressed: controller.onPressed,
    );
  }
}
