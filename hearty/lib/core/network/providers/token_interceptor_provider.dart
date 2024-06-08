import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ports/index.dart';

/// A [Provider] for the [TokenInterceptor] that should be implemented
/// and overridden in the dependency injection setup.
///
/// Throws [UnimplementedError] by default to ensure an implementation
/// is provided in the dependency injection setup.
final tokenInterceptorProvider = Provider<TokenInterceptor>(
  (ref) => throw UnimplementedError(),
  name: 'TokenInterceptorProvider',
);
