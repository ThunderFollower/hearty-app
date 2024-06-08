import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'index.dart';

abstract class PasswordVisibilityController
    extends StateNotifier<PasswordVisibilityState> {
  PasswordVisibilityController(super.state);

  void changeVisibilityState();
  void handleTextChanging(String input);
}
