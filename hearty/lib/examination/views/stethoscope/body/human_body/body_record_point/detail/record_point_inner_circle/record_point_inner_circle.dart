import 'package:flutter/material.dart';

import '../../../../../../../../core/views/theme/indentation_constants.dart';

class RecordPointInnerCircle extends StatelessWidget {
  const RecordPointInnerCircle({
    super.key,
    required this.nameId,
    required this.color,
  });

  final Color color;
  final String nameId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: middleIndent,
          height: middleIndent,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        Text(
          '${nameId.replaceAll(' ', '_').toLowerCase().replaceAll("'", '')}_point',
          style: const TextStyle(fontSize: 0),
          overflow: TextOverflow.clip,
        ),
      ],
    );
  }
}
