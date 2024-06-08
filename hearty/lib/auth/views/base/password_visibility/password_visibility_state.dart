class PasswordVisibilityState {
  final bool isPasswordVisible;
  final bool shouldShowVisibilityIcon;

  const PasswordVisibilityState({
    this.isPasswordVisible = false,
    this.shouldShowVisibilityIcon = false,
  });

  PasswordVisibilityState copyWith({
    bool? isPasswordVisible,
    bool? shouldShowVisibilityIcon,
  }) =>
      PasswordVisibilityState(
        isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
        shouldShowVisibilityIcon:
            shouldShowVisibilityIcon ?? this.shouldShowVisibilityIcon,
      );
}
