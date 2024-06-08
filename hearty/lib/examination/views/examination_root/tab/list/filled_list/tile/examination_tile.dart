import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../../../../core/core.dart';
import '../../../../../../../core/views.dart';
import '../../../../../../../generated/locale_keys.g.dart';
import '../../../../../main_page/content/common/index.dart';
import 'controller/providers.dart';

part 'examination_tile_card.dart';
part 'examination_tile_content.dart';
part 'examination_tile_content_leading.dart';
part 'examination_tile_content_subtitle.dart';
part 'examination_tile_content_title.dart';
part 'examination_tile_content_trailing.dart';
part 'examination_tile_list_item.dart';
part 'examination_tile_slidable_card.dart';

class ExaminationTile extends StatelessWidget {
  static final _borderRadius = BorderRadius.circular(lowIndent);
  static const _padding = EdgeInsets.symmetric(horizontal: middleIndent);

  final String examinationId;
  final bool? received;

  const ExaminationTile({
    super.key,
    required this.examinationId,
    this.received,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ClipRRect(
      borderRadius: _borderRadius,
      child: _SlidableCard(examinationId, received: received),
    );
    return _wrap(tile);
  }

  Widget _wrap(Widget tile) {
    final semantics = Semantics(
      key: ValueKey('ExaminationTile: $examinationId'),
      enabled: true,
      focusable: true,
      child: tile,
    );
    return Padding(padding: _padding, child: semantics);
  }
}
