import 'package:flutter/services.dart';

import 'sign_in_helper.dart';

/// Enum defining method names for method channel calls.
enum _Methods {
  isOpenedByLink,
}

/// An implementation of [SignInHelper] for iOS.
class SignInHelperIosAdapter implements SignInHelper {
  static const platform = MethodChannel(
    'sparrowacoustics.com/native',
  );

  @override
  Future<bool?> hasLaunchOptions() => platform.invokeMethod<bool>(
        _Methods.isOpenedByLink.name,
      );
}
