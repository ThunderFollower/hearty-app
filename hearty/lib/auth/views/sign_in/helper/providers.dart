import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_helper.dart';
import 'sign_in_helper_ios_adapter.dart';

/// A provider that supplies an instance of [SignInHelper] based on the current
/// platform.
final signInHelperProvider = Provider.autoDispose<SignInHelper>((ref) {
  if (Platform.isIOS) return SignInHelperIosAdapter();
  // Add additional platform checks here if other platforms are supported in
  // the future.
  throw UnsupportedError(
    'Native Store is not supported for the current platform',
  );
});
