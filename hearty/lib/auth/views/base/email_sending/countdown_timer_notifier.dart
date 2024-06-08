import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Encapsulate the application's logic of a state of Countdown Timer.
class CountdownTimerNotifier extends StateNotifier<Duration> {
  Timer? _countdownTimer;

  /// Duration of this Countdown Timer.
  final Duration duration;
  final Duration interval;

  /// Create a Countdown Timer with the given [duration]
  /// that will be updated on the specified [interval]
  /// while the countdown [state] is positive.
  CountdownTimerNotifier({
    required this.duration,
    required this.interval,
  }) : super(duration);

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  /// Returns whether the Countdown Timer is still active.
  bool get isActive => _countdownTimer?.isActive ?? false;

  /// Start this timer.
  void startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(interval, onTimerTick);
  }

  /// Stop this timer.
  void stopTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
  }

  /// Set a countdown value to the specified [countdown].
  void setCountdown(Duration countdown) {
    if (countdown.inMilliseconds <= 0) {
      stopTimer();
      state = Duration.zero;
    } else {
      state = countdown;
    }
  }

  /// Update the state by the [timer] tick.
  void onTimerTick(Timer timer) {
    final reducingBy = timer.tick * interval.inMicroseconds;
    final microseconds = duration.inMicroseconds - reducingBy;
    setCountdown(Duration(microseconds: microseconds));
  }
}
