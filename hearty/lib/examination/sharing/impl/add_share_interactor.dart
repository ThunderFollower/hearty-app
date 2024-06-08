import '../../../auth/auth.dart';
import '../../../auth/biometric/biometric_service.dart';
import '../../../core/core.dart';
import '../../../utils/mixins/index.dart';
import '../add_share_use_case.dart';
import '../share_service.dart';

/// Implements the [AddShareUseCase].
class AddShareInteractor extends AddShareUseCase with SubscriptionManager {
  AddShareInteractor({
    this.shareService,
    this.signOut,
    this.tokenService,
    this.credentialsService,
    this.biometricService,
  });

  final ShareService? shareService;
  final AsyncCommand<bool>? signOut;
  final TokenService? tokenService;
  final CredentialsService? credentialsService;
  final BiometricService? biometricService;

  void dispose() {
    cancelSubscriptions();
  }

  @override
  Future<void> execute(String id) async {
    if (await _shouldSignIn() && await signOut?.execute() == false) {
      biometricService?.createBiometricsRequest();
    }

    final subscription = tokenService
        ?.selectToken()
        .where(_defined)
        .where(_authenticatedWithSecondFactor)
        .take(1)
        .listen(
      (_) {
        shareService?.add(id);
      },
    );

    if (subscription != null) addSubscription(subscription);
  }

  Future<bool> _shouldSignIn() async =>
      await _isAuthenticated() == false ||
      await _isTokenExpired() ||
      await _hasMoreThanOneAccount();

  Future<bool> _hasMoreThanOneAccount() async {
    final credentials = await credentialsService?.load().first;
    final count = credentials?.length ?? 0;
    return count > 1;
  }

  Future<bool> _isAuthenticated() async {
    final hasTokens = await tokenService?.hasTokens();
    return hasTokens ?? false;
  }

  Future<bool> _isTokenExpired() async {
    final tokens = await tokenService?.get();
    return tokens?.isExpired ?? true;
  }
}

/// Return `true` where the [event] is defined.
bool _defined(AuthToken? event) => event != null;

/// Return `true` where the [event] has been authenticated with the second
/// factor.
bool _authenticatedWithSecondFactor(AuthToken? event) =>
    event?.needTFA == false;
