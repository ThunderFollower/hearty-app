class MainDrawerState {
  final bool isDoctorModeEnabled;
  final bool isBiometricEnabled;
  final bool isMicEnabled;
  final bool isLocationEnabled;
  final String? biometricLabel;

  const MainDrawerState({
    this.isDoctorModeEnabled = false,
    this.isBiometricEnabled = false,
    this.isMicEnabled = false,
    this.isLocationEnabled = false,
    this.biometricLabel,
  });

  MainDrawerState copyWith({
    bool? isDoctorModeEnabled,
    bool? isBiometricEnabled,
    bool? isMicEnabled,
    bool? isLocationEnabled,
    String? biometricLabel,
  }) =>
      MainDrawerState(
        isDoctorModeEnabled: isDoctorModeEnabled ?? this.isDoctorModeEnabled,
        isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
        biometricLabel: biometricLabel ?? this.biometricLabel,
        isMicEnabled: isMicEnabled ?? this.isMicEnabled,
        isLocationEnabled: isLocationEnabled ?? this.isLocationEnabled,
      );
}
