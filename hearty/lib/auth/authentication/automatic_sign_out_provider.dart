import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/core.dart';
import '../auth.dart';
import 'impl/automatic_sign_out_decorator.dart';

/// Defines an instance of the [AutomaticSignOutDecorator].
final automaticSignOutProvider = Provider.autoDispose<AsyncCommand<bool>>(
  (ref) => AutomaticSignOutDecorator(
    ref.watch(signOutProvider),
    ref.watch(showErrorNotificationProvider),
  ),
);
