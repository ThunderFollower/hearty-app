import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../impl/post_account_delete_controller_adapter.dart';
import '../post_account_delete_controller.dart';

/// Provides an instance of [PostAccountDeleteController].
final postAccountDeleteControllerProvider =
    Provider.autoDispose<PostAccountDeleteController>(
  (ref) => PostAccountDeleteControllerAdapter(
    router: ref.watch(routerProvider),
  ),
);
