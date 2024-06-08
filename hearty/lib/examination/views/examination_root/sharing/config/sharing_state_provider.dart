import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/views/router_provider.dart';
import '../../../../../utils/utils.dart';
import '../../../../examination.dart';
import '../impl/sharing_controller_adapter.dart';
import '../sharing_controller.dart';
import '../sharing_state.dart';

final sharingStateProvider = StateNotifierProvider.autoDispose
    .family<SharingController, SharingState, String>(
  (ref, id) {
    ref.delayDispose();
    return SharingControllerAdapter(
      ref.watch(routerProvider),
      ref.watch(showAcknowledgmentsDialogProvider),
      id,
      ref.watch(examinationsServiceProvider),
      ref.watch(recordServiceProvider),
      ref.watch(assetServiceProvider),
    );
  },
);
