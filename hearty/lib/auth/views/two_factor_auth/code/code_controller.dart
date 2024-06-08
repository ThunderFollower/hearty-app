import 'package:flutter/widgets.dart';

/// Defines the interface for the controller of the code form.
abstract class CodeController {
  /// The controller of confirmation code input field.
  TextEditingController get editController;

  /// The focus node of confirmation code input field.
  FocusNode get focusNode;

  /// Update the current confirmation code with the new [code].
  ///
  /// Called when code is changed.
  void updateCode(String code);
}
