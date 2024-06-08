import 'package:flutter/material.dart';

import 'record_point_inner_circle/record_point_inner_circle.dart';

class NonActiveRecordPoint extends StatelessWidget {
  const NonActiveRecordPoint({super.key, required this.nameId});

  final String nameId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onPrimaryContainer.withOpacity(0.3);

    return RecordPointInnerCircle(nameId: nameId, color: color);
  }
}
