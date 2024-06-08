import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../auth.dart';
import 'choose_account_controller.dart';
import 'choose_account_controller_adapter.dart';

/// Provides a [ChooseAccountController] to the ChooseAccountDialog.
final chooseAccountControllerProvider =
    Provider.autoDispose<ChooseAccountController>(
  (ref) => ChooseAccountControllerAdapter(
    ref.watch(credentialsServiceProvider),
    ref.watch(forgotPasswordInteractorProvider),
    ref.watch(routerProvider),
  ),
);
