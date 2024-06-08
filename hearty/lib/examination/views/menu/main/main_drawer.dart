import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/views.dart';
import '../../../../generated/locale_keys.g.dart';
import '../settings/index.dart';
import '../settings/main_drawer_controller/main_drawer_controller.dart';
import '../settings/main_drawer_controller/main_drawer_state.dart';
import 'button/text_button_tile.dart';
import 'logo/horizontal_logo.dart';
import 'property/drawer_property.dart';

class MainDrawer extends ConsumerWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mainDrawerControllerProvider.notifier);
    final state = ref.watch(mainDrawerControllerProvider);

    final theme = Theme.of(context);
    final logoutIconColor = theme.colorScheme.secondary;

    const horizontalLogo = HorizontalLogo();
    final userGuides = _buildUserGuides(controller);
    final doctorModeProperty = _buildAppModeProperty(
      state,
      controller,
    );
    final microphoneProperty = _buildMicrophoneProperty(
      state,
      controller,
    );
    final biometricProperty = _buildBiometricProperty(
      state,
      controller,
    );
    final geolocationProperty = _buildGeolocationProperty(
      state,
      controller,
    );

    final language = _buildLanguage(controller);
    final logOutButton = _buildLogOutButton(controller, logoutIconColor);
    final legal = _buildLegal(controller);
    const extremelyHightSizedBox = SizedBox(height: extremelyHightIndent);
    final column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        extremelyHightSizedBox,
        horizontalLogo,
        _smallSpacer,
        userGuides,
        _smallSpacer,
        _bigSpacer,
        doctorModeProperty,
        microphoneProperty,
        biometricProperty,
        geolocationProperty,
        _bigSpacer,
        language,
        _smallSpacer,
        _smallSpacer,
        legal,
        _smallSpacer,
        logOutButton,
      ],
    );
    final padding = Padding(padding: _padding, child: column);

    return Drawer(child: padding);
  }

  Widget _buildLegal(MainDrawerController controller) => LabelListTile(
        title: _legalText,
        onTap: controller.openLegalPage,
      );

  TextButtonTile _buildLogOutButton(
    MainDrawerController controller,
    Color color,
  ) =>
      TextButtonTile(
        color: color,
        text: _logOutText,
        icon: AppIcons.logOut,
        onTap: controller.signOut,
      );

  Widget _buildLanguage(MainDrawerController controller) => LabelListTile(
        title: _languageText,
        onTap: controller.openAppLanguageSettings,
      );

  DrawerProperty _buildGeolocationProperty(
    MainDrawerState state,
    MainDrawerController controller,
  ) =>
      DrawerProperty(
        key: _geolocationKey,
        isTurnedOn: state.isLocationEnabled,
        title: _geolocationText,
        handler: controller.switchLocationState,
      );

  Widget _buildBiometricProperty(
    MainDrawerState state,
    MainDrawerController controller,
  ) =>
      state.biometricLabel != null
          ? DrawerProperty(
              key: _biometricsKey,
              isTurnedOn: state.isBiometricEnabled,
              title: state.biometricLabel!,
              handler: controller.switchBiometricState,
            )
          : const SizedBox.shrink();

  DrawerProperty _buildMicrophoneProperty(
    MainDrawerState state,
    MainDrawerController controller,
  ) =>
      DrawerProperty(
        key: _microphoneKey,
        isTurnedOn: state.isMicEnabled,
        title: _microphoneText,
        handler: controller.switchMicrophoneState,
      );

  DrawerProperty _buildAppModeProperty(
    MainDrawerState state,
    MainDrawerController controller,
  ) =>
      DrawerProperty(
        key: _appModeKey,
        isTurnedOn: state.isDoctorModeEnabled,
        title: _doctorModeText,
        handler: controller.switchDoctorMode,
        infoTap: controller.showDoctorModeInfo,
      );

  Widget _buildUserGuides(MainDrawerController controller) => LabelListTile(
        title: _userGuidesText,
        onTap: controller.openUserGuidesPage,
      );
}

final _userGuidesText = LocaleKeys.User_Guides.tr();
final _microphoneText = LocaleKeys.Microphone.tr();
final _doctorModeText = LocaleKeys.Doctor_Mode.tr();
final _geolocationText = LocaleKeys.Geolocation.tr();
final _languageText = LocaleKeys.Language.tr();
final _legalText = LocaleKeys.Legal.tr();
final _logOutText = LocaleKeys.Log_out.tr();
const _bigSpacer = Spacer(flex: 4);
const _smallSpacer = Spacer();
const _padding = EdgeInsets.only(
  right: lowestIndent,
  left: middleIndent,
  bottom: aboveLowestIndent,
);

// Keys
const _appModeKey = Key('app_mode_key');
const _geolocationKey = Key('geolocation_key');
const _biometricsKey = Key('biometrics_key');
const _microphoneKey = Key('microphone_key');
