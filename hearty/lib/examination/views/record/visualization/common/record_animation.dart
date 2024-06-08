import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/utils.dart';
import '../../controller/providers.dart';
import '../../controller/record_state.dart';

part 'record_animation_state.dart';

class RecordAnimation extends ConsumerStatefulWidget {
  const RecordAnimation({
    super.key,
    required this.width,
    required this.recordId,
    required this.margin,
    required this.child,
  });

  /// Widget width.
  final double width;

  /// Identifier for the associated audio record.
  final String recordId;

  final EdgeInsetsGeometry margin;
  final Widget? child;

  @override
  ConsumerState<RecordAnimation> createState() => _RecordAnimationState();
}
