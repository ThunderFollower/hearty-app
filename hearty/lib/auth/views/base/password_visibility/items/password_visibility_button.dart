import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/views/theme/index.dart';

class PasswordVisibilityButton extends StatelessWidget {
  const PasswordVisibilityButton({
    required this.isPasswordVisible,
    required this.onTap,
  });

  final bool isPasswordVisible;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final svgPicture = SvgPicture.asset(
      isPasswordVisible ? _showPasswordImage : _hidePasswordImage,
      width: middleIndent,
      height: middleIndent,
    );
    final gestureDetector = GestureDetector(onTap: onTap, child: svgPicture);

    return Semantics(
      label: _passwordVisibilityButtonLabel,
      button: true,
      child: Padding(padding: _padding, child: gestureDetector),
    );
  }
}

const _showPasswordImage = 'assets/images/password_shown.svg';
const _hidePasswordImage = 'assets/images/password_hidden.svg';
const _padding = EdgeInsets.only(right: 25);

/// Labels for testing.
const _passwordVisibilityButtonLabel = 'password_visibility_button';
