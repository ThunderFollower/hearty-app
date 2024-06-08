import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import 'modal_message_controller.dart';
import 'modal_message_controller_provider.dart';

/// Encapsulates a presentation of the Modal Message notification screen.
@RoutePage()
class ModalMessagePage extends ConsumerWidget {
  /// Create a new [ModalMessagePage].
  ModalMessagePage({
    super.key,
    this.icon,
    required this.captionText,
    required this.descriptionText,
    String? buttonText,
  }) : buttonText = buttonText ?? LocaleKeys.OK.tr();

  final Widget? icon;
  final String captionText;
  final String descriptionText;
  final String buttonText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(modalMessageControllerProvider);

    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimary.withOpacity(_semiOpaque);

    final root = _buildRoot(controller, theme);
    return AppScaffold(backgroundColor: color, body: root);
  }

  Widget _buildCaption(ThemeData theme) {
    final color = theme.colorScheme.onPrimary;
    final style = theme.textTheme.titleLarge?.copyWith(color: color);

    return Text(
      captionText,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget _buildDescription(ThemeData theme) {
    final color = theme.colorScheme.onTertiaryContainer;
    final style = theme.textTheme.bodyMedium?.copyWith(color: color);

    return Text(
      descriptionText,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  Widget _buildContentRoot(
    ModalMessageController controller,
    ThemeData theme,
  ) {
    final caption = _buildCaption(theme);
    final description = _buildDescription(theme);
    final dismissButton = _buildDismissButton(controller);

    final children = [
      caption,
      const SizedBox(height: lowIndent),
      description,
      const SizedBox(height: middleIndent),
      dismissButton,
    ];

    if (icon != null) {
      children.insert(0, icon!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
  }

  Widget _buildRoot(
    ModalMessageController controller,
    ThemeData theme,
  ) {
    final body = _buildBody(controller, theme);
    final key = Key(captionText);
    final dismissible = Dismissible(
      onDismissed: (_) => controller.dismiss(),
      direction: DismissDirection.down,
      key: key,
      child: body,
    );

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.dismiss,
      child: dismissible,
    );
  }

  Widget _buildBody(
    ModalMessageController controller,
    ThemeData theme,
  ) {
    final content = _buildContentContainer(controller, theme);
    final children = [
      const Spacer(),
      const TopStripe(),
      content,
    ];
    return Column(children: children);
  }

  Widget _buildContentContainer(
    ModalMessageController controller,
    ThemeData theme,
  ) {
    final content = _buildContentRoot(controller, theme);
    final color = theme.colorScheme.primaryContainer;

    final boxDecoration = BoxDecoration(
      color: color,
      borderRadius: _borderRadius,
    );

    return Container(
      height: _viewHeight,
      margin: _margin,
      padding: _padding,
      decoration: boxDecoration,
      child: content,
    );
  }

  Widget _buildDismissButton(ModalMessageController controller) =>
      RoundCornersButton(
        title: buttonText,
        onTap: controller.dismiss,
      );
}

const _semiOpaque = 0.6;
const _borderRadius = BorderRadius.all(Radius.circular(highIndent));
const _padding = EdgeInsets.all(middleIndent);
const _margin = EdgeInsets.only(
  left: lowIndent,
  right: lowIndent,
  top: aboveLowestIndent,
  bottom: middleIndent,
);
const _viewHeight = 320.0;
