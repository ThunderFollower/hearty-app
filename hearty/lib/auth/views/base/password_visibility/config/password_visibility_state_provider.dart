import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../index.dart';

final passwordVisibilityStateProvider = StateNotifierProvider.autoDispose
    .family<PasswordVisibilityController, PasswordVisibilityState, Key>(
  (ref, _) {
    const defaultState = PasswordVisibilityState();
    return PasswordVisibilityControllerAdapter(state: defaultState);
  },
);
