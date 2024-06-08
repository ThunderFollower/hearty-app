import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/views.dart';
import '../../../generated/locale_keys.g.dart';

/// Implements a visual structure of the Sign In screen.
///
/// This widget enables scrolling to the screen content
/// when it does not fit the screen size.
class SignInScaffold extends StatelessWidget {
  /// Creates a visual scaffold for the Sign In screen.
  /// If the [body] is not null, it will be used as the primary content.
  const SignInScaffold({
    super.key,
    this.body,
    this.onPressed,
  });

  /// The primary content of the scaffold.
  final Widget? body;

  /// The callback function to invoke when the button is pressed.
  ///
  /// If this is null, the button will be disabled.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: _buildScrollableBody(),
        appBar: _buildAppBar(),
      );

  Widget _buildScrollableBody() =>
      SingleChildScrollView(padding: _padding, child: body);

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text(key: _loginTitleKey, LocaleKeys.Landing_LogIn.tr()),
        leading: BackIconButton(key: _backButtonKey, onPressed: onPressed),
        leadingWidth: BackIconButton.leadingWidth,
      );
}

const _padding = EdgeInsets.symmetric(horizontal: middleIndent);

// Keys
const _backButtonKey = Key('back_button_key');
const _loginTitleKey = Key('title_bar_text');
