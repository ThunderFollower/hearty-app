import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../../../core/views.dart';
import '../../../../../../../../generated/locale_keys.g.dart';

part 'record_error_text.dart';

const _padding = EdgeInsets.all(belowMediumIndent);

class RecordError extends StatelessWidget {
  const RecordError({super.key});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: _padding,
        child: const FittedBox(fit: BoxFit.scaleDown, child: _Text()),
      );
}
