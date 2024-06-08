import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Extends [AutoDisposeRef] to provide a delayed disposal mechanism.
///
/// By using the [delayDispose] method, a provider's auto-disposal can be
/// postponed by a specified [Duration], allowing it to stay alive for
/// a longer period before being disposed.
extension DisposeDelay on AutoDisposeRef {
  /// Delays the disposal of the provider by [delay] (defaulting to 5 seconds).
  ///
  /// If the provider gets re-acquired before the delay completes, the disposal
  /// is canceled.
  void delayDispose([Duration? delay]) {
    final actualDelay = delay ?? const Duration(seconds: 5);
    final link = keepAlive();

    Timer? timer;

    // Cancel the timer when the provider is disposed.
    onDispose(_cancelTimer(timer));

    // Set a timer to close the link after the actual delay.
    onCancel(() => timer = _setDisposeTimer(link, actualDelay));

    // Cancel the timer if the provider is resumed.
    onResume(() => _cancelTimer(timer));
  }

  VoidCallback _cancelTimer(Timer? timer) {
    return () => timer?.cancel();
  }

  Timer _setDisposeTimer(KeepAliveLink link, Duration delay) {
    return Timer(delay, () => link.close());
  }
}
