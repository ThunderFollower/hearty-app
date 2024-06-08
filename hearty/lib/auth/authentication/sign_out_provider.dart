import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../../core/views.dart';
import '../auth.dart';
import 'impl/sign_out_interactor.dart';

/// Defines the singleton instance of the [AsyncCommand].
final signOutProvider = Provider.autoDispose<AsyncCommand<bool>>(
  (ref) => SignOutInteractor(
    ref.watch(routerProvider),
    ref.watch(authProfileServiceProvider),
    path: '/auth',
  ),
);
