import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/locale_keys.g.dart';
import '../../common/index.dart';

/// Defines a view of the empty state of the My Examinations list.
class MyEmptyList extends StatelessWidget {
  /// Create a new [MyEmptyList].
  const MyEmptyList({super.key});

  @override
  Widget build(BuildContext context) =>
      EmptyExaminationList(title: _title, description: _description);
}

final _title = LocaleKeys.No_examinations_yet.tr();
final _description = LocaleKeys
    .Create_an_examination_to_save_heart_and_lungs_sound_recordings.tr();
