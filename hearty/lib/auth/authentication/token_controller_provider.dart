import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../account/index.dart';
import 'automatic_sign_out_provider.dart';
import 'token_controller.dart';

/// A provider that creates a [TokenController] instance with the appropriate
/// dependencies.
final tokenControllerProvider = Provider.autoDispose(
  (ref) => TokenController(
    ref.watch(tokenInterceptorProvider),
    ref.watch(authProfileServiceProvider),
    ref.watch(automaticSignOutProvider),
  ),
);
