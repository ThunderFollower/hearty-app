import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/views.dart';
import '../../../../../generated/locale_keys.g.dart';

class EmptyRecordsAlert extends StatelessWidget {
  const EmptyRecordsAlert({super.key});

  @override
  Widget build(BuildContext context) {
    const stripe = TopStripe();

    final theme = Theme.of(context);
    final color = theme.colorScheme.primaryContainer;

    final titleText = Text(
      _title,
      textAlign: TextAlign.center,
      style: textStyleOfBlackPearlColorMedium18,
    );

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(highIndent),
      color: color,
    );

    final contentColumn = Column(
      children: [titleText],
    );

    final container = Container(
      padding: _padding,
      decoration: decoration,
      child: contentColumn,
    );

    final column = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [stripe, container],
    );

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: column,
    );
  }
}

final _title = LocaleKeys.There_are_no_recordings_in_this_examination.tr();

const _padding = EdgeInsets.only(
  left: middleIndent,
  right: middleIndent,
);
