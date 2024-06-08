import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config.dart';
import 'countdown_timer_notifier.dart';

/// Provides the state of the Countdown Timer to resend an email notification.
final emailSendingCountdownProvider =
    StateNotifierProvider<CountdownTimerNotifier, Duration>(
  (ref) => CountdownTimerNotifier(
    duration: const Duration(seconds: Config.maxResendCodeTickCount),
    interval: const Duration(seconds: 1),
  ),
);
