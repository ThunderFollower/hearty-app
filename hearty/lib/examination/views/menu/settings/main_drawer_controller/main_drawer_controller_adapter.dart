import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../app_router.gr.dart';
import '../../../../../auth/account/auth_profile_service.dart';
import '../../../../../auth/account/user_role.dart';
import '../../../../../auth/biometric/biometric.dart';
import '../../../../../auth/biometric/biometric_service.dart';
import '../../../../../core/core.dart';
import '../../../../../core/views/show_modal_dialog.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../../../../utils/utils.dart';
import '../../main/explanatory_dialog.dart';
import '../show_settings_dialog.dart';
import 'main_drawer_controller.dart';

class MainDrawerControllerAdapter extends MainDrawerController
    with SubscriptionManager, WidgetsBindingObserver {
  MainDrawerControllerAdapter(
    super.state,
    this._key,
    this._router,
    this._openHelpCenter,
    this._documentsPath,
    this._signOut,
    this._authProfileService,
    this._biometricService,
    this._micPermissionService,
    this._locationPermissionService, {
    required this.openAppSettings,
  }) {
    _authProfileService
        .observeProfileChanges()
        .map((event) => event?.role)
        .distinct()
        .listen(_listenRole)
        .addToList(this);

    _biometricService
        .observeBiometricChanges()
        .distinct()
        .listen(_listenBiometric)
        .addToList(this);

    _refreshMicStatus();
    _micPermissionService
        .observeStatusChanges()
        .listen(_listenMicrophone)
        .addToList(this);

    _refreshLocationStatus();
    _locationPermissionService
        .observeStatusChanges()
        .listen(_listenLocation)
        .addToList(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshMicStatus();
      _refreshLocationStatus();
    }
  }

  Future<void> _refreshMicStatus() async {
    final isEnabled = await _micPermissionService.isGranted();
    // Mind the gap! I mean the asynchronous gap.
    if (mounted) state = state.copyWith(isMicEnabled: isEnabled);
  }

  Future<void> _refreshLocationStatus() async {
    final isEnabled = await _locationPermissionService.isGranted();
    // Mind the gap! I mean the asynchronous gap.
    if (mounted) state = state.copyWith(isLocationEnabled: isEnabled);
  }

  void _listenRole(UserRole? event) {
    state = state.copyWith(isDoctorModeEnabled: event == UserRole.doctor);
  }

  void _listenBiometric(Biometric event) {
    state = state.copyWith(
      isBiometricEnabled: event.isEnabled,
      biometricLabel: event.label,
    );
  }

  void _listenMicrophone(PermissionStatus status) {
    state = state.copyWith(isMicEnabled: status.isGranted);
  }

  void _listenLocation(PermissionStatus status) {
    state = state.copyWith(isLocationEnabled: status.isGranted);
  }

  final StackRouter _router;

  /// A command to open the help center in the default browser or app.
  final AsyncCommand _openHelpCenter;

  final String _documentsPath;

  /// A command to sign out the current user.
  final AsyncCommand _signOut;

  final AuthProfileService _authProfileService;

  final BiometricService _biometricService;

  final Future<void> Function() openAppSettings;

  final PermissionService _micPermissionService;

  final PermissionService _locationPermissionService;

  /// The [GlobalKey] used to access the application's navigation context.
  final GlobalKey _key;

  @override
  Future<void> openAppLanguageSettings() => openAppSettings.call();

  @override
  Future<void> openFeedbackPage() => _router.push<void>(const FeedbackRoute());

  @override
  Future<void> openLegalPage() {
    final path = _resolvePath(_documentsPath, true);
    return _router.pushNamed(path);
  }

  String _resolvePath(String path, bool value) =>
      '$path?containsDeleteAccountButton=$value';

  @override
  Future<void> openUserGuidesPage() =>
      _router.push<void>(const GuideListRoute());

  @override
  Future<void> openHelpCenter() => _openHelpCenter.execute();

  @override
  void switchDoctorMode() {
    final role = _takeUserRole(!state.isDoctorModeEnabled);
    _authProfileService.setCurrentUserRole(role);
  }

  UserRole _takeUserRole(bool isDoctorMode) =>
      isDoctorMode ? UserRole.doctor : UserRole.patient;

  @override
  void switchBiometricState() {
    if (state.isBiometricEnabled) {
      _biometricService.disableBiometric();
    } else {
      _biometricService.enableBiometric();
    }
  }

  @override
  Future<void> signOut() => _signOut.execute();

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  Future<void> showDeclickerInfo() => _showDialog(
        LocaleKeys.Declicker.tr(),
        LocaleKeys.Reduces_excessive_noise_created_when_shifting_the_phone.tr(),
        LocaleKeys.Please_disable_for_mechanical_prosthetic_valves.tr(),
      );

  @override
  Future<void> showDoctorModeInfo() => _showDialog(
        LocaleKeys.Doctor_Mode.tr(),
        LocaleKeys.Recommended_for_use_by_medical_professionals.tr(),
        LocaleKeys.Enables_a_Stethoscope_with_different_sound_filters.tr(),
      );

  Future<void> _showDialog(String title, String description, String bodyInfo) {
    final context = _key.currentContext;
    assert(context != null);
    if (context == null) return Future.value();

    final dialog = ExplanatoryDialog(
      title: title,
      description: description,
      bodyInfo: bodyInfo,
    );

    return showModalDialog(child: dialog, context: context);
  }

  @override
  Future<void> switchMicrophoneState() async {
    final isDenied = await _micPermissionService.isPermanentlyDenied();
    if (state.isMicEnabled || isDenied) {
      _configureMicDialog();
    } else {
      _micPermissionService.grant();
    }
  }

  @override
  Future<void> switchLocationState() async {
    final isDenied = await _locationPermissionService.isPermanentlyDenied();
    if (state.isLocationEnabled || isDenied) {
      _configureLocationDialog();
    } else {
      _locationPermissionService.grant();
    }
  }

  void _configureMicDialog() {
    final title = (state.isMicEnabled
        ? _micPermissionTitleDisable
        : _micPermissionTitleEnable);
    final body = (state.isMicEnabled
        ? _micPermissionBodyDisable
        : _micPermissionBodyEnable);
    return _showSettingDialog(title, body, _micPermissionIconPath);
  }

  void _configureLocationDialog() {
    final title = (state.isLocationEnabled
        ? _geoPermissionTitleDisable
        : _geoPermissionTitleEnable);
    final body = (state.isLocationEnabled
        ? _geoPermissionBodyDisable
        : _geoPermissionBodyEnable);
    return _showSettingDialog(title, body, _geoPermissionIconPath);
  }

  void _showSettingDialog(String title, String body, String iconPath) {
    final context = _key.currentContext;
    assert(context != null);
    if (context == null) return;

    showSettingsDialog(
      context: context,
      title: title.tr(),
      body: body.tr(),
      iconPath: iconPath,
      onTap: openAppSettings,
    );
  }
}

const _micPermissionIconPath = 'assets/images/microphone.svg';
const _micPermissionTitleEnable = LocaleKeys.Enable_Microphone_Access;
const _micPermissionTitleDisable = LocaleKeys.Disable_Microphone_Access;
const _micPermissionBodyEnable = LocaleKeys
    .This_allows_you_to_record_heart_and_lungs_sounds_and_listen_in_real_time;

const _geoPermissionIconPath = 'assets/images/update_app.svg';
const _geoPermissionTitleEnable = LocaleKeys.Enable_Geolocation_Access;
const _geoPermissionTitleDisable = LocaleKeys.Disable_Geolocation_Access;
const _geoPermissionBodyEnable = LocaleKeys
    .This_allows_you_to_associate_examinations_with_a_certain_location;
const _geoPermissionBodyDisable =
    LocaleKeys.Examinations_will_no_longer_be_associated_with_the_location;
const _micPermissionBodyDisable = LocaleKeys
    .You_will_no_longer_be_able_to_record_heart_and_lungs_sounds_and_listen_in_real_time;
