import '../../core/core.dart';
import '../../utils/utils.dart';
import '../account/index.dart';

/// A controller class for managing authentication tokens.
class TokenController with SubscriptionManager {
  /// Constructs a new [TokenController] with the given [TokenInterceptor],
  /// [AuthProfileService], and [AsyncCommand] for signing out.
  TokenController(
    this._interceptor,
    this._service,
    this._signOut,
  ) {
    _service
        .observeProfileChanges()
        .map((profile) => profile?.accessToken)
        .distinct()
        .listen((accessToken) => _interceptor.accessToken = accessToken)
        .addToList(this);
    _interceptor.onRemoveToken = _onRemoveToken;
    _interceptor.onRefresh = _onRefresh;
  }

  final TokenInterceptor _interceptor;
  final AuthProfileService _service;
  final AsyncCommand<bool> _signOut;

  /// Disposes of this [TokenController] instance and its associated resources.
  void dispose() {
    cancelSubscriptions();
    if (_interceptor.onRemoveToken == _onRemoveToken) {
      _interceptor.onRemoveToken = null;
    }
    if (_interceptor.onRefresh == _onRefresh) _interceptor.onRefresh = null;
  }

  /// The callback function for handling token refresh requests.
  ///
  /// Returns a [Future] that resolves to a new access token, or `null` if the
  /// refresh request failed.
  Future<String?> _onRefresh() async {
    final profile = await _service.refreshCurrentUser();
    return profile?.accessToken;
  }

  /// The callback function for handling token removal requests.
  Future<void> _onRemoveToken() async {
    await _signOut.execute();
  }
}
