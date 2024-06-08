import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

/// Encapsulates management of [StreamSubscription]s.
mixin SubscriptionManager {
  final _compositeSubscription = CompositeSubscription();
  final _cancellationNotifier = StreamController.broadcast();

  /// Cancel all [StreamSubscription]s managed by this manager.
  void cancelSubscriptions() {
    _compositeSubscription.dispose();
    _compositeSubscription.clear();
    _cancellationNotifier.add(null);
    _cancellationNotifier.close();
  }

  /// Manage the given [subscription].
  void addSubscription(StreamSubscription subscription) {
    _compositeSubscription.add(subscription);
  }

  /// A stream that emits a value when active subscriptions should be canceled.
  ///
  /// Listen to this stream to be notified when the underlying resources or
  /// subscriptions managed by this mixin are meant to be released or canceled.
  /// Typically used with stream operators like `takeUntil` to auto-cancel
  /// streams when a specific event occurs.
  @protected
  @visibleForTesting
  Stream get cancellation => _cancellationNotifier.stream;
}
