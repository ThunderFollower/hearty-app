import 'dart:async';

import '../config.dart';

class Debouncer {
  Timer? _throttleTimer;
  Future? _debounceFuture;

  Future<void> debounce(
    Future Function() callback, {
    Duration duration = Config.defaultDebounceDuration,
  }) async {
    if (_throttleTimer?.isActive != true) {
      _debounceFuture = callback();
      _throttleTimer = _throttleTimer ??
          Timer(duration, () {
            _throttleTimer?.cancel();
            _throttleTimer = null;
            _debounceFuture = null;
          });
    }

    return _debounceFuture;
  }
}
