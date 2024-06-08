import 'package:flutter/material.dart';

import 'show_notification_interactor.dart';

/// Displays error notifications.
class ShowErrorNotificationInteractor extends ShowNotificationInteractor {
  const ShowErrorNotificationInteractor(
    super.messengerKey, {
    super.autoDismiss,
  });

  @override
  Color? get background => theme?.colorScheme.errorContainer;

  @override
  Color? get foreground => theme?.colorScheme.onError;
}
