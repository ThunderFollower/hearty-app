import 'package:flutter/material.dart';

import '../../../../../../../core/views.dart';

class MenuButtonSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => IconButton(
        icon: Icon(
          AppIcons.actions,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        iconSize: 25.0,
        onPressed: () {},
      );
}
