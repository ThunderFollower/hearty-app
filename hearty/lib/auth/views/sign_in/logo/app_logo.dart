import 'package:flutter/material.dart';

import '../../../../core/views.dart';

/// Encapsulates representation of the Application Logo.
class AppLogo extends StatelessWidget {
  /// Creates a new [AppLogo].
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    const upper = LocalImage(assetPath: _logoAssetName);

    return Column(
      children: [
        upper,
        Text(
          'Hearty',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}

const _logoAssetName = 'assets/images/logo.png';
