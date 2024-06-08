import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/views.dart';
import 'modal_message_controller.dart';
import 'modal_message_controller_adapter.dart';

/// Provides the [ModalMessageController] for the Modal Message Page.
final modalMessageControllerProvider =
    Provider.autoDispose<ModalMessageController>(
  (ref) => ModalMessageControllerAdapter(ref.watch(routerProvider)),
);
