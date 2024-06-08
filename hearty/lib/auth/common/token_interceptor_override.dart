import '../../core/core.dart';
import 'adapters/token_interceptor_adapter.dart';

/// Overrides the default [tokenInterceptorProvider] with an instance of
/// [TokenInterceptorAdapter] for dependency injection.
///
/// This can be used when setting up the app's dependency injection.
final tokenInterceptorOverride =
    tokenInterceptorProvider.overrideWith((ref) => TokenInterceptorAdapter());
