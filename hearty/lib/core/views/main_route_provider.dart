import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _emptyPageRoute = PageRouteInfo('', args: '');

/// Provides the main route of the application.
/// You should use it to push the main page to a router.
///
/// Example:
/// ```dart
/// router.push(ref.read(mainRouteProvider));
/// ```
final mainRouteProvider = Provider<PageRouteInfo>((_) => _emptyPageRoute);
