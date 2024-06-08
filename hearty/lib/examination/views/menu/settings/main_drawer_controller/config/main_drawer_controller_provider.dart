import 'package:app_settings/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../auth/auth.dart';
import '../../../../../../auth/biometric/config/biometric_service_provider.dart';
import '../../../../../../core/core.dart';
import '../../../../../../core/views.dart';
import '../main_drawer_controller.dart';
import '../main_drawer_controller_adapter.dart';
import '../main_drawer_state.dart';

/// Provides an instance of [MainDrawerController]
final mainDrawerControllerProvider =
    StateNotifierProvider.autoDispose<MainDrawerController, MainDrawerState>(
  (ref) => MainDrawerControllerAdapter(
    const MainDrawerState(),
    ref.watch(navigatorKeyProvider),
    ref.watch(routerProvider),
    ref.watch(openHelpCenterProvider),
    _documentsPath,
    ref.watch(signOutProvider),
    ref.watch(authProfileServiceProvider),
    ref.watch(biometricServiceProvider),
    ref.watch(permissionService(Permission.microphone)),
    ref.watch(permissionService(Permission.locationWhenInUse)),
    openAppSettings: ref.watch(openAppSettingsProvider),
  ),
);

const _documentsPath = '/documents-list';

final openAppSettingsProvider = Provider(
  (ref) => () => AppSettings.openAppSettings(),
);
