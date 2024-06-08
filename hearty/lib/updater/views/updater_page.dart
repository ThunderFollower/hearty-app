import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/views.dart';
import '../../generated/locale_keys.g.dart';
import 'controller/controller.dart';

/// A page to inform the user about an available update and direct them to the store.
@RoutePage()
class UpdaterPage extends StatelessWidget {
  const UpdaterPage({super.key});

  static const String imagePath = 'assets/images/error.svg';
  static const padding = EdgeInsets.symmetric(horizontal: highIndent);

  @override
  Widget build(BuildContext context) {
    // Content of the updater page, including image and texts
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(imagePath),
        const SizedBox(height: highIndent),
        const _Title(),
        const SizedBox(height: middleIndent),
        const _Description(),
        const SizedBox(height: middleIndent),
        const _ActionButton(),
      ],
    );
    return _wrap(context, content);
  }

  /// Wraps the content in a Scaffold with appropriate padding and background color.
  Widget _wrap(BuildContext context, Widget widget) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: SafeArea(minimum: padding, child: widget),
      );
}

/// Displays the title of the updater page.
class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) => Text(
        LocaleKeys.Updater_title,
        textAlign: TextAlign.center,
        style: _buildStyle(context),
      ).tr();

  /// Builds the text style for the title based on the current theme.
  TextStyle? _buildStyle(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimary;
    return theme.textTheme.titleLarge?.copyWith(color: color);
  }
}

/// Displays the description text on the updater page.
class _Description extends StatelessWidget {
  const _Description();

  static const padding = EdgeInsets.symmetric(horizontal: belowLowIndent);

  @override
  Widget build(BuildContext context) {
    final text = Text(
      LocaleKeys.Updater_description,
      textAlign: TextAlign.center,
      style: _buildStyle(context),
    ).tr();

    return _wrap(text);
  }

  /// Builds the text style for the description based on the current theme.
  TextStyle? _buildStyle(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onTertiaryContainer;
    return theme.textTheme.titleMedium?.copyWith(color: color);
  }

  /// Wraps the text widget in padding.
  Widget _wrap(Widget widget) => Padding(padding: padding, child: widget);
}

/// A button that, when tapped, triggers the update action.
class _ActionButton extends ConsumerWidget {
  const _ActionButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch for the updater controller provider
    final controller = ref.watch(updaterControllerProvider);
    return RoundCornersButton(
      title: LocaleKeys.Updater_action.tr(),
      onTap: controller.openStore,
    );
  }
}
