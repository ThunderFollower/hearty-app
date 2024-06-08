import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../views.dart';
import 'show_notification.dart';

/// Base class for showing notifications.
abstract class ShowNotificationInteractor implements ShowNotification {
  const ShowNotificationInteractor(
    this._messengerKey, {
    this.autoDismiss = true,
  });

  final GlobalKey _messengerKey;

  /// True to auto hide after duration.
  final bool autoDismiss;

  // Background color for the notification.
  @protected
  Color? get background;

  // Foreground color for the notification.
  @protected
  Color? get foreground => theme?.colorScheme.onPrimary;

  // Retrieves the theme based on the current context.
  @protected
  ThemeData? get theme {
    final currentContext = _messengerKey.currentContext;
    return currentContext == null ? null : Theme.of(currentContext);
  }

  // Displays a simple notification.
  @override
  OverlaySupportEntry execute(Widget content) => showSimpleNotification(
        content,
        background: background,
        foreground: foreground,
        contentPadding: const EdgeInsets.symmetric(horizontal: middleIndent),
        autoDismiss: autoDismiss,
      );
}
