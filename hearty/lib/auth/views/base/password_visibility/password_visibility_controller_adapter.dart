import 'index.dart';

class PasswordVisibilityControllerAdapter extends PasswordVisibilityController {
  PasswordVisibilityControllerAdapter({
    required PasswordVisibilityState state,
  }) : super(state);

  @override
  void changeVisibilityState() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  @override
  void handleTextChanging(String input) {
    state = state.copyWith(shouldShowVisibilityIcon: input.isNotEmpty);
  }
}
