import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

/// `ShowNotification` is an abstract class representing a use case for
/// displaying notifications.
abstract class ShowNotification {
  /// Executes the use case to show the notification.
  ///
  /// Takes a `Widget` [content] as input which represents the content to be
  /// displayed in the notification.
  /// Returns an `OverlaySupportEntry` which is a handle to the displayed
  /// notification.
  /// This handle can be used to programmatically dismiss the notification or to
  /// check if it is currently displayed.
  OverlaySupportEntry execute(Widget content);
}
