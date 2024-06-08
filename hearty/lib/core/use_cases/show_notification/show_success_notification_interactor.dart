import 'package:flutter/material.dart';

import 'show_notification_interactor.dart';

/// Displays success notifications.
class ShowSuccessNotificationInteractor extends ShowNotificationInteractor {
  const ShowSuccessNotificationInteractor(
    super.messengerKey, {
    super.autoDismiss,
  });

  @override
  Color? get background => theme?.colorScheme.tertiaryContainer;

  @override
  Color? get foreground => theme?.colorScheme.onInverseSurface;
}
