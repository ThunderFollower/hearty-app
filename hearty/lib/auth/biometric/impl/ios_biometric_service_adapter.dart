import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/locale_keys.g.dart';
import '../biometric.dart';
import '../biometric_exception.dart';
import '../biometric_service.dart';
import '../entities/ios_biometric.dart';

class IOSBiometricServiceAdapter extends BiometricService {
  IOSBiometricServiceAdapter(this._asyncPreferences, this._logger);

  final Future<SharedPreferences> _asyncPreferences;

  final Logger _logger;

  /// A stream controller used to manage biometrics requests.
  final _biometricsRequestController = StreamController.broadcast();

  /// To listen the biometric's changes
  final _biometricStream = StreamController<Biometric>.broadcast();

  /// A flag to indicate if a biometric authentication process is currently in
  /// progress.
  /// If `_isBiometricsInProgress` is set to `true`, it means a biometric
  /// authentication operation is ongoing, and any new request to initiate
  /// another biometric authentication should be ignored.
  /// If set to `false`, it implies that no biometric authentication is taking
  /// place and a new request can be initiated.
  bool _isBiometricsInProgress = false;

  void dispose() {
    _biometricsRequestController.close();
    _biometricStream.close();
  }

  @override
  Stream<Biometric> observeBiometricChanges() async* {
    final label = await _label;
    final isEnabled = await _isEnabled();

    yield IOSBiometric(isEnabled: isEnabled, label: label);
    yield* _biometricStream.stream;
  }

  Future<String?> get _label async {
    final availableBiometrics =
        await LocalAuthentication().getAvailableBiometrics();

    String? label;
    if (availableBiometrics.contains(BiometricType.face)) {
      label = 'Face ID';
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      label = 'Touch ID';
    }

    return label;
  }

  @override
  Future<void> init() async {
    final isInitialAuth = (await _asyncPreferences).getBool(_biometricKey);
    if (isInitialAuth == null) _enableBiometric();
  }

  @override
  Future<void> enableBiometric() async {
    if (!await _isEnabled()) _enableBiometric();
  }

  Future<void> _enableBiometric() async {
    try {
      final labelText = await _label;
      final localizedReason = LocaleKeys
          .Enable_biometric_to_log_in_without_entering_your_password.tr(
        args: [if (labelText != null) labelText],
      );

      final isAuthenticated = await _authenticate(localizedReason);
      (await _asyncPreferences).setBool(_biometricKey, isAuthenticated);
      final updatedBiometric = IOSBiometric(
        isEnabled: isAuthenticated,
        label: labelText,
      );

      _biometricStream.sink.add(updatedBiometric);
    } on PlatformException catch (e, stackTrace) {
      _logger.e('Biometric auth failed.', e, stackTrace);
    }
  }

  Future<bool> _isEnabled() async =>
      (await _asyncPreferences).getBool(_biometricKey) ?? false;

  @override
  Future<void> disableBiometric() async {
    (await _asyncPreferences).setBool(_biometricKey, false);
    final labelText = await _label;
    final updatedBiometric = IOSBiometric(isEnabled: false, label: labelText);

    _biometricStream.sink.add(updatedBiometric);
  }

  @override
  Future<void> authenticate() async {
    _isBiometricsInProgress = true;
    try {
      final authenticated = await _authenticate(
        LocaleKeys.Please_authenticate_to_log_in.tr(),
      );
      if (!authenticated) throw const BiometricException();
    } finally {
      _isBiometricsInProgress = false;
    }
  }

  Future<bool> _authenticate(String localizedReason) {
    const options = AuthenticationOptions(stickyAuth: true);

    return LocalAuthentication().authenticate(
      localizedReason: localizedReason,
      options: options,
    );
  }

  /// Creates a new biometrics request and adds it to the sink.
  ///
  /// [data] represents the data associated with the biometrics request.
  @override
  void createBiometricsRequest([dynamic data]) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _biometricsRequestController.sink.add(data);
    });
  }

  /// Returns a stream of biometrics requests.
  ///
  /// Use this method to listen for incoming biometrics requests and handle them
  /// accordingly.
  @override
  Stream<dynamic> listenBiometricsRequest() =>
      _biometricsRequestController.stream
          .where((_) => !_isBiometricsInProgress);
}

const _biometricKey = 'is_biometric_enabled_key';
