import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config.dart';
import '../../../../../core/views.dart';
import '../../../../examination/entities/detail/predefined_examination_points.dart';
import '../../../examination/index.dart';
import '../../providers.dart';
import '../../stethoscope_controller.dart';
import 'body_record_point/body_record_point.dart';

const _bodyImageBaseWidth = 583;
const _bodyLineWidth = 1.5;
const _bodyLineOpacity = 0.3;

class StethoscopeSheetHumanBody extends ConsumerWidget {
  const StethoscopeSheetHumanBody({super.key, this.sizeRestrictions});

  final Size? sizeRestrictions;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bodySide = ref.watch(
      examinationStateProvider.select((state) => state.bodySide),
    );
    final organType = ref.watch(
      examinationStateProvider.select((state) => state.organType),
    );

    final examinationPoints = ref.watch(
      examinationStateProvider
          .select((state) => state.examination.valueOrNull?.examinationPoints),
    );
    if (examinationPoints == null) return const Loader();

    final size = sizeRestrictions ?? MediaQuery.of(context).size;
    final height = _computeHeight(size);
    final double translateQuotient = _computeTranslateQuotient(size);
    final isSaving = ref.watch(
      stethoscopeStateProvider.select(
        (value) => value.recordingState.state == RecordingStates.saving,
      ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (DragUpdateDetails details) =>
          isSaving ? null : _closeOnSwipeDown(context, details),
      child: Container(
        width: size.width,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: _bodyLineWidth,
              color: theme.colorScheme.secondary.withOpacity(_bodyLineOpacity),
            ),
          ),
        ),
        child: Transform.translate(
          offset: Offset(0, height * translateQuotient),
          child: Stack(
            children: [
              Image(
                semanticLabel: 'examination_page',
                width: double.infinity,
                image: AssetImage(
                  'assets/images/body_${bodySide.name.toLowerCase()}_with_hands.png',
                ),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
              ...examinationPoints
                  .where(
                (rp) =>
                    rp.point.bodySide == bodySide && rp.point.type == organType,
              )
                  .map(
                (rp) {
                  final rpOffset = PredefinedExaminationPoints
                      .stethoscopeBodyExaminationPoints
                      .where((element) => element.point.spot == rp.point.spot)
                      .first
                      .point;
                  return BodyRecordPoint(
                    id: rp.id!,
                    offsetX: rpOffset.offsetX,
                    offsetY: rpOffset.offsetY,
                    records: rp.records,
                    spot: rp.point.spot,
                    nameId: rp.point.name,
                    width: sizeRestrictions!.width,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _computeHeight(Size screenSize) =>
      screenSize.width / _bodyImageBaseWidth;

  double _computeTranslateQuotient(Size screenSize) {
    final aspectRatio = screenSize.width / screenSize.height;
    final quotient = Config.bodyImageNormalScreenAspectRatio - aspectRatio;
    final translateQuotient =
        quotient - (quotient >= 0 ? 0 : Config.bodyImageQuotientShift);
    return translateQuotient;
  }

  void _closeOnSwipeDown(BuildContext context, DragUpdateDetails details) {
    if (details.delta.dy > Config.swipeDownThreshold) {
      context.router.pop();
    }
  }
}
