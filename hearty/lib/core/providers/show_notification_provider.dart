import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';
import '../use_cases/show_notification/show_error_notification_interactor.dart';
import '../use_cases/show_notification/show_success_notification_interactor.dart';

/// Provider for error notification
final showErrorNotificationProvider = Provider.autoDispose<ShowNotification>(
  (ref) => ShowErrorNotificationInteractor(ref.read(navigatorKeyProvider)),
);

/// Provider for success notification
final showSuccessNotificationProvider = Provider.autoDispose<ShowNotification>(
  (ref) => ShowSuccessNotificationInteractor(ref.read(navigatorKeyProvider)),
);
