import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/utils.dart';
import '../common/device_identifier_service.dart';
import 'config/auth_token_repository_provider.dart';
import 'ports/auth_token_repository.dart';
import 'token_service.dart';

final twoFactorAuthServiceProvider = Provider.autoDispose<TwoFactorAuthService>(
  (ref) {
    final twoFactorAuthRepository = ref.watch(authTokenRepositoryProvider);
    final tokenServiceInstance = ref.watch(tokenService);
    final deviceIdentifierServiceInstance = ref.watch(deviceIdentifierService);
    return TwoFactorAuthService(
      twoFactorAuthRepository,
      tokenServiceInstance,
      deviceIdentifierServiceInstance,
    );
  },
);

class TwoFactorAuthService {
  final AuthTokenRepository _authTokenRepository;
  final TokenService _tokenService;
  final DeviceIdentifierService _deviceIdentifierService;

  TwoFactorAuthService(
    this._authTokenRepository,
    this._tokenService,
    this._deviceIdentifierService,
  );

  Future<void> requestCode() async {
    final deviceId = await _deviceIdentifierService.getDeviceIdentifier();
    final userAgent = await UserAgentBuilder.build();

    await _authTokenRepository.generateOneTimePassword(
      deviceIdentifier: deviceId,
      userAgent: userAgent,
    );
  }

  Future<void> sendCode({required String code}) async {
    final deviceId = await _deviceIdentifierService.getDeviceIdentifier();
    final userAgent = await UserAgentBuilder.build();
    final token = await _authTokenRepository.authenticate(
      code,
      deviceIdentifier: deviceId,
      userAgent: userAgent,
    );

    final result = token.copyWith(needTFA: false);
    await _tokenService.update(result);
  }
}
