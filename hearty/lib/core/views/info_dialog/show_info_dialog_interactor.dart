import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../core.dart';
import 'info_dialog.dart';

/// An implementation of [ShowAlertUseCase] that shows an info dialog.
class ShowInfoDialogInteractor implements ShowAlertUseCase {
  /// Creates a new instance of [ShowInfoDialogInteractor].
  ///
  /// [_router] is the [StackRouter] that will be used to show the dialog.
  const ShowInfoDialogInteractor(this._router);

  /// A router that will be used to show the dialog.
  final StackRouter _router;

  @override
  Future<T?> execute<T>({
    required String title,
    String? buttonTitle,
    void Function()? onPressed,
  }) async {
    final context = _router.navigatorKey.currentState?.context;
    assert(context != null, 'context is required');

    // Show the info dialog and wait for it to close.
    return showDialog<T?>(
      context: context!,
      builder: (_) => _buildInfoDialog(title, buttonTitle, onPressed),
    );
  }

  /// Builds the info dialog with the provided parameters.
  ///
  /// [title] is the title of the dialog.
  ///
  /// [buttonTitle] is the text that will be displayed on the button. If not
  /// provided, a default text will be used.
  ///
  /// [onPressed] is a function that will be called when the button is pressed.
  /// If not provided, the dialog will simply be closed.
  Widget _buildInfoDialog(
    String title,
    String? buttonTitle,
    void Function()? onPressed,
  ) =>
      InfoDialog(
        title: title,
        buttonTitle: buttonTitle,
        onButtonTap: onPressed ?? _router.pop,
      );
}
