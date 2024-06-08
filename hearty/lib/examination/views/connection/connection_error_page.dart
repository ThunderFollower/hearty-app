import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';
import 'config/connection_controller_provider.dart';
import 'connection_controller.dart';
import 'connectivity_state.dart';

@RoutePage()
class ConnectionErrorPage extends ConsumerWidget {
  const ConnectionErrorPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.tryAgainTap,
  });

  final String imagePath;
  final String title;
  final String description;
  final VoidCallback tryAgainTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(connectionControllerProvider.notifier);
    final state = ref.watch(connectionControllerProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.setIsOpen());

    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.primaryContainer;

    final body = _buildBody(theme, controller, state);
    final safeArea = SafeArea(minimum: _safeAreaPadding, child: body);

    return AppScaffold(backgroundColor: backgroundColor, body: safeArea);
  }

  Column _buildBody(
    ThemeData theme,
    ConnectionController controller,
    ConnectivityState state,
  ) {
    final titleTextStyle = theme.textTheme.headlineLarge;
    final bodyTextColor = theme.colorScheme.onTertiaryContainer;
    final bodyTextStyle = theme.textTheme.bodyMedium?.copyWith(
      color: bodyTextColor,
    );

    final titleText = Text(
      title,
      textAlign: TextAlign.center,
      style: titleTextStyle,
    );
    final image = SvgPicture.asset(imagePath);
    final descriptionText = Text(
      description,
      textAlign: TextAlign.center,
      style: bodyTextStyle,
    );
    final tryAgainButton = RoundCornersButton(
      title: LocaleKeys.Try_again.tr(),
      onTap: tryAgainTap,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        image,
        const SizedBox(height: veryHighIndent),
        titleText,
        const SizedBox(height: middleIndent),
        descriptionText,
        const SizedBox(height: middleIndent),
        tryAgainButton,
        const Spacer(),
        if (state.isAuthenticated) _buildStethoscope(controller),
      ],
    );
  }

  Widget _buildStethoscope(ConnectionController controller) {
    final stethoscope = StethoscopeButton(onTap: controller.openStethoscope);
    // Row is here to locate button to the left side of the screen
    return Row(children: [stethoscope]);
  }
}

const _safeAreaPadding = EdgeInsets.symmetric(horizontal: highIndent);
