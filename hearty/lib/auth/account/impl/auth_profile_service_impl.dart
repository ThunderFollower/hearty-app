import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/utils.dart';
import '../../authentication/entities/auth_token.dart';
import '../../authentication/token_service.dart';
import '../auth_profile_service.dart';
import '../constants.dart';
import '../credentials_service.dart';
import '../entities/auth_profile.dart';
import '../ports/index.dart';
import '../user_role.dart';

/// An implementation of [AuthProfileService] that uses [AuthProfileRepository]
/// to manage authentication profiles.
class AuthProfileServiceImpl
    with SubscriptionManager
    implements AuthProfileService {
  /// Constructs a new instance of [AuthProfileServiceImpl].
  ///
  /// The instance is initialized with the following parameters:
  /// - [_authProfileRepository]: A repository for managing authentication profiles.
  /// - [_emailController]: A controller for handling email interactions.
  /// - [_credentialsService]: A service for managing user credentials.
  /// - [_tokenService]: A service for managing tokens.
  /// - [_asyncPreferences]: A utility for handling asynchronous preferences.
  /// - [_logger]: A utility for logging actions and state changes in this class.
  ///
  /// Upon construction, the service starts listening to token changes from [_tokenService],
  /// transforms them to [AuthProfile] instances using the [_mapToAuthProfile] method,
  /// and adds the new profiles to the [_profileStream] sink.
  AuthProfileServiceImpl(
    this._authProfileRepository,
    this._emailController,
    this._credentialsService,
    this._tokenService,
    this._asyncPreferences,
    this._logger,
  ) {
    _tokenService
        .selectToken()
        .asyncMap(_mapToAuthProfile)
        .listen(_profileStream.sink.add)
        .addToList(this);
  }

  /// A repository to manage authentication profiles.
  final AuthProfileRepository _authProfileRepository;

  // TODO: Encapsulate storing a profile
  // It will allow deprecating the `CredentialsService`, `TokenService`, and the
  // email provider.

  /// A [StateController] to store the email of the authenticated profile.
  final StateController<String> _emailController;

  /// A service to manage credentials.
  final CredentialsService _credentialsService;

  /// A service to manage tokens.
  final TokenService _tokenService;

  final Future<SharedPreferences> _asyncPreferences;

  /// To listen the profile's changes
  final _profileStream = BehaviorSubject<AuthProfile?>(sync: true);

  /// The utility for logging actions and state changes in this class.
  final Logger _logger;

  /// Disposes all the subscriptions added to this manager by canceling them.
  ///
  /// After calling this method, the subscriptions should no longer emit events.
  void dispose() {
    cancelSubscriptions();
    _profileStream.close();
  }

  @override
  Future<void> signUpByEmail(String email, String password) async {
    // Attempt to sign up the user using the email and password.
    final profile = await _authProfileRepository.signUpByEmail(email, password);

    // Store the authenticated profile's email.
    _emailController.state = profile.email;

    _profileStream.add(profile);

    // Save the user's credentials.
    await _credentialsService.save(login: email, password: password);

    // If the authenticated profile has tokens, store them.
    await _updateCurrentUser(profile);
  }

  Future<void> _updateCurrentUser(AuthProfile profile) async {
    // If the authenticated profile has tokens, store them.
    if (profile.accessToken != null && profile.refreshToken != null) {
      final updatedToken = AuthToken(
        id: profile.id,
        accessToken: profile.accessToken!,
        refreshToken: profile.refreshToken!,
        expiresInDate: profile.expiresAt,
        needTFA: !profile.is2FAAuthenticated,
      );
      await _tokenService.update(updatedToken);
    } else {
      // Clear any existing tokens.
      await _tokenService.clear();
    }
  }

  @override
  Stream<AuthProfile?> observeProfileChanges() => MergeStream([
        _tokenService.selectToken().take(1).asyncMap(_mapToAuthProfile),
        _profileStream.stream,
      ]).distinct();

  Future<AuthProfile?> _mapToAuthProfile(AuthToken? event) async {
    if (event == null) return null;
    return AuthProfile(
      id: event.id,
      email: _emailController.state,
      accessToken: event.accessToken,
      expiresAt: event.expiresInDate,
      refreshToken: event.refreshToken,
      is2FAAuthenticated: event.needTFA,
      role: await _takeRole(),
    );
  }

  Future<UserRole> _takeRole() async {
    final isDoctorMode = await _isDoctorModeEnabled();
    return isDoctorMode ? UserRole.doctor : UserRole.patient;
  }

  Future<bool> _isDoctorModeEnabled() async =>
      (await _asyncPreferences).getBool(doctorModeKey) ?? false;

  @override
  Future<void> setCurrentUserRole(UserRole role) async {
    final profile = await _takeProfile();
    if (profile != null) {
      final updatedProfile = profile.copyWith(role: role);
      await _saveAppModeState(role);
      _profileStream.sink.add(updatedProfile);
    }
  }

  Future<void> _saveAppModeState(UserRole role) async {
    (await _asyncPreferences).setBool(doctorModeKey, role == UserRole.doctor);
  }

  Future<AuthProfile?> _takeProfile() async {
    final tokens = await _tokenService.get();

    if (tokens == null) return null;

    return AuthProfile(
      id: tokens.id,
      email: _emailController.state,
      accessToken: tokens.accessToken,
      expiresAt: tokens.expiresInDate,
      refreshToken: tokens.refreshToken,
      is2FAAuthenticated: tokens.needTFA,
    );
  }

  @override
  Future<void> signOut() async {
    await _tokenService.clear();
    _emailController.state = '';
    _profileStream.sink.add(null);
  }

  String? get _email =>
      _emailController.state.isEmpty ? null : _emailController.state;

  @override
  Future<void> deleteProfile() async {
    assert(_email != null, 'User must be authenticated.');
    final email = _email!;

    await _authProfileRepository.deleteProfile();
    await _credentialsService.remove(login: email);
    await _tokenService.clear();

    _profileStream.sink.add(null);
  }

  @override
  Future<bool> get isNotEmpty => _credentialsService.hasCredentials();

  @override
  Future<AuthProfile?> refreshCurrentUser() async {
    final profile = await _takeProfile();
    if (profile == null) return null;

    try {
      final updatedProfile = await _authProfileRepository.refresh(profile);
      await _updateCurrentUser(updatedProfile);
      return updatedProfile;
    } catch (error, stackTrace) {
      _logger.e('Cannot refresh the current user', error, stackTrace);
      return null;
    }
  }
}
