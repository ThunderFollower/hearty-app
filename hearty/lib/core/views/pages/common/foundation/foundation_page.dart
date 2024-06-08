import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../title/title_text.dart';
import 'controller/controller.dart';

/// This widget is the fundamental building block for other pages. It provides
/// the foundational elements upon which other pages are built and carries a
/// sense of robustness and essential functionality.
class FoundationPage extends ConsumerWidget {
  /// Creates a [FoundationPage].
  ///
  /// Allows specifying an app bar title, a custom widget for the title,
  /// a leading widget, an icon for dismissal, and a body widget.
  /// Only one of [title] or [titleText] should be provided, and similarly,
  /// only one of [leading] or [dismissIcon] should be provided.
  const FoundationPage({
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.dismissIcon,
    this.child,
  })  : assert(title == null || titleText == null),
        assert(leading == null || dismissIcon == null);

  /// The widget to be used as the title in the app bar.
  ///
  /// If non-null, this widget is displayed as the title. This takes precedence
  /// over [titleText]. Only one of [title] or [titleText] should be provided.
  final Widget? title;

  /// A text string to be used as the title in the app bar.
  ///
  /// If [title] is null and this is provided, [titleText] is displayed as a
  /// simple text title. Only one of [title] or [titleText] should be provided.
  final String? titleText;

  /// The main content of the page.
  ///
  /// This widget is displayed as the body of the `Scaffold`.
  final Widget? child;

  /// A widget to be placed in the leading position of the app bar.
  ///
  /// If non-null, this widget is displayed as the leading widget in the app bar.
  /// It takes precedence over [dismissIcon]. Only one of [leading] or
  /// [dismissIcon] should be provided.
  final Widget? leading;

  /// An icon to be used for a dismiss action in the leading position of the app bar.
  ///
  /// If [leading] is null and this is provided, an `IconButton` with [dismissIcon]
  /// is displayed as the leading widget. The button triggers the dismiss action
  /// defined in [FoundationPageController]. Only one of [leading] or
  /// [dismissIcon] should be provided.
  final IconData? dismissIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(foundationPageControllerProvider);
    return Scaffold(
      appBar: buildAppBar(controller),
      body: child,
    );
  }

  @visibleForTesting
  @protected
  PreferredSizeWidget? buildAppBar(FoundationPageController controller) {
    final titleWidget = buildTitle();
    final leadingWidget = buildLeading(controller);
    if (titleWidget == null) return null;

    return AppBar(
      leading: leadingWidget,
      title: titleWidget,
    );
  }

  @visibleForTesting
  @protected
  Widget? buildTitle() {
    if (title != null) return title;

    final titleText = this.titleText;
    if (titleText == null) return null;

    return TitleText(titleText);
  }

  @visibleForTesting
  @protected
  Widget? buildLeading(FoundationPageController controller) {
    if (leading != null) return leading;

    final dismissIcon = this.dismissIcon;
    if (dismissIcon == null) return null;

    final button = IconButton(
      onPressed: controller.dismiss,
      icon: Icon(dismissIcon),
    );

    return Semantics(
      label: '${titleText ?? ''}Dismiss',
      tooltip: 'Dismiss',
      focusable: true,
      image: true,
      header: true,
      button: true,
      child: button,
    );
  }
}
