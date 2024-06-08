import 'package:flutter/material.dart';

import '../theme/text_style_constants.dart';
import 'back_title_bar_item.dart';
import 'close_title_bar_item.dart';

/// Defines common [TitleBar].
class TitleBar extends AppBar {
  /// Create a [TitleBar] with the given [title] text.
  ///
  /// If the [appBarTheme] is not null, it overrides the default values of
  /// visual properties for the [TitleBar] widget.
  factory TitleBar(
    String title, {
    AppBarTheme? appBarTheme,
  }) =>
      TitleBar._(
        titleText: title,
        appBarTheme: appBarTheme,
      );

  /// Create a [TitleBar] with the given [title] text and [leading] back button.
  ///
  /// If the [appBarTheme] is not null, it overrides the default values of
  /// visual properties for the [TitleBar] widget.
  factory TitleBar.withBackButton(
    String title, {
    Widget? leading,
    double? leadingWidth,
    AppBarTheme? appBarTheme,
  }) =>
      TitleBar._(
        titleText: title,
        leading: leading ?? const BackTitleBarItem(),
        leadingWidth: leadingWidth,
        appBarTheme: appBarTheme,
      );

  /// Create a [TitleBar] with the given [title] text and [leading] back button.
  ///
  /// If the [appBarTheme] is not null, it overrides the default values of
  /// visual properties for the [TitleBar] widget.
  factory TitleBar.withCloseButton(
    String title, {
    Widget? leading,
    double? leadingWidth,
    AppBarTheme? appBarTheme,
  }) =>
      TitleBar._(
        titleText: title,
        leading: leading ?? const CloseTitleBarItem(),
        leadingWidth: leadingWidth,
        appBarTheme: appBarTheme,
      );

  /// Create a [TitleBar] with the given [widget] text and [leading] back button.
  ///
  /// If the [appBarTheme] is not null, it overrides the default values of
  /// visual properties for the [TitleBar] widget.
  factory TitleBar.withBackButtonAndWidget(
    Widget title, {
    Widget? leading,
    double? leadingWidth,
    AppBarTheme? appBarTheme,
  }) =>
      TitleBar._(
        title: title,
        leading: leading ?? const BackTitleBarItem(),
        leadingWidth: leadingWidth,
        appBarTheme: appBarTheme,
      );

  TitleBar._({
    String? titleText,
    Widget? title,
    super.leading,
    super.leadingWidth,
    AppBarTheme? appBarTheme,
  })  : assert(title != null || titleText != null),
        super(
          actionsIconTheme: appBarTheme?.actionsIconTheme,
          backgroundColor: appBarTheme?.backgroundColor ?? Colors.pink.shade100,
          centerTitle: appBarTheme?.centerTitle ?? true,
          elevation: appBarTheme?.elevation ?? 0.0,
          foregroundColor: appBarTheme?.foregroundColor,
          iconTheme: appBarTheme?.iconTheme,
          shadowColor: appBarTheme?.shadowColor,
          shape: appBarTheme?.shape,
          systemOverlayStyle: appBarTheme?.systemOverlayStyle,
          titleSpacing: appBarTheme?.titleSpacing,
          titleTextStyle: appBarTheme?.titleTextStyle,
          toolbarHeight: appBarTheme?.toolbarHeight,
          toolbarTextStyle: appBarTheme?.toolbarTextStyle,
          title: title ??
              Text(
                key: _titleBarText,
                titleText!,
                style: appBarTheme?.titleTextStyle ?? textStyleOfPageTitle,
              ),
        );
}

// Keys
const _titleBarText = Key('title_bar_text');
