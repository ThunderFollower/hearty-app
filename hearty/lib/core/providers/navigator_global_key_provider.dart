import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Defines a [GlobalKey] of [NavigatorState] that's used globally throughout
/// the application.
final _navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'NavigatorKey');

/// Exposes a [GlobalKey] of [NavigatorState] that's used globally throughout
/// the application.
final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => _navigatorKey,
);
