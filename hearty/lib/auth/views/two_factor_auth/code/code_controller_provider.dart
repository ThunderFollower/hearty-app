import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../two_factor_auth_controller_adapter_provider.dart';
import 'code_controller.dart';

/// Provides the [CodeController].
final codeControllerProvider = Provider.autoDispose<CodeController>(
  (ref) => ref.watch(twoFactorAuthControllerAdapterProvider.notifier),
);
