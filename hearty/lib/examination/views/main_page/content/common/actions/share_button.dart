import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'share_button_controller_provider.dart';

/// Encapsulates presentation of the Share Action Button
class ShareButton extends ConsumerWidget {
  const ShareButton({
    super.key,
    required this.examinationId,
  });

  final String examinationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final controllerProvider = shareButtonControllerProvider(
      examinationId,
    );
    final controller = ref.watch(controllerProvider);

    final color = theme.colorScheme.primaryContainer;
    final colorFilter = ColorFilter.mode(color, BlendMode.srcIn);

    return IconButton(
      icon: SvgPicture.asset(_assetName, colorFilter: colorFilter),
      onPressed: controller.onPressed,
    );
  }
}

const _assetName = 'assets/images/share.svg';
