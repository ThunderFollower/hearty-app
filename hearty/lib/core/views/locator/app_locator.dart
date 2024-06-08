import 'package:flutter/material.dart';

import '../theme/text_style_constants.dart';

class AppLocator extends StatelessWidget {
  const AppLocator({super.key, required this.child, required this.id});

  final Widget child;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Text(
          id,
          style: textStyleOfInvisibleTextSize0,
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
