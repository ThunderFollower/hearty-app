import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../../config.dart';
import '../common/common.dart';

part 'chrono_ruler_graduation.dart';
part 'chrono_ruler_major_divisions.dart';
part 'chrono_ruler_minor_divisions.dart';
part 'chrono_ruler_state.dart';
part 'chrono_ruler_unit_text.dart';
part 'chrono_ruler_unit.dart';

class ChronoRuler extends VisualizationWidget {
  const ChronoRuler({
    super.key,
    required super.width,
    required super.recordId,
    required super.duration,
    required this.extraSectionsPadding,
    required this.margin,
  });

  final double extraSectionsPadding;
  final EdgeInsetsGeometry margin;
  static const double height = 24;

  @override
  ConsumerState<ChronoRuler> createState() => _ChronoRulerState();
}
