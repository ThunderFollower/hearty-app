import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/locale_keys.g.dart';
import '../../common/index.dart';

/// Defines a view of the empty state of the Received Examinations list.
class EmptyReceivedList extends StatelessWidget {
  /// Create a new [EmptyReceivedList].
  const EmptyReceivedList({super.key});

  @override
  Widget build(BuildContext context) =>
      EmptyExaminationList(title: _title, description: _description);
}

final _title = LocaleKeys.No_examinations_yet.tr();
final _description =
    LocaleKeys.You_can_receive_examinations_from_other_people.tr();
