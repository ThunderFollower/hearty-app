import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'two_factor_auth_controller.dart';
import 'two_factor_auth_controller_adapter_provider.dart';
import 'two_factor_auth_state.dart';

/// Provides the [TwoFactorAuthState].
final AutoDisposeStateNotifierProvider<TwoFactorAuthController,
        TwoFactorAuthState> twoFactorAuthStateProvider =
    twoFactorAuthControllerAdapterProvider;
