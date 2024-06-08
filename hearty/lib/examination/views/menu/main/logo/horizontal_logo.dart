import 'package:flutter/material.dart';

import '../../../../../core/views.dart';

class HorizontalLogo extends StatelessWidget {
  const HorizontalLogo();

  @override
  Widget build(BuildContext context) {
    final logoImage = Image.asset(
      _logoPath,
      height: veryHighIndent,
      width: veryHighIndent,
    );

    return Row(
      children: [
        logoImage,
        const SizedBox(width: lowestIndent),
        Text(
          'Hearty',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

const _logoPath = 'assets/images/logo.png';
