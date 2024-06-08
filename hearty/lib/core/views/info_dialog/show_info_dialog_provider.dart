import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core.dart';
import '../router_provider.dart';
import 'show_info_dialog_interactor.dart';

/// A provider that creates an instance of [ShowAlertUseCase] to show an info
/// dialog.
final showInfoDialogProvider = Provider.autoDispose<ShowAlertUseCase>(
  (ref) => ShowInfoDialogInteractor(
    ref.watch(routerProvider),
  ),
);
