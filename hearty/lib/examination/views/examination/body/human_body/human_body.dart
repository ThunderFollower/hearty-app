import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config.dart';
import '../../../../examination.dart';
import '../../providers.dart';
import 'record_point/record_point_view.dart';

class HumanBody extends ConsumerWidget {
  const HumanBody({
    super.key,
    required this.examinationPoints,
    this.mutable = true,
  });

  final List<ExaminationPoint> examinationPoints;

  /// If mutable is true, deleting or updating audio is granted.
  /// Otherwise, it's prohibited.
  final bool mutable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bodySide = ref.watch(
      examinationStateProvider.select((state) => state.bodySide),
    );
    final organType = ref.watch(
      examinationStateProvider.select((state) => state.organType),
    );

    final screenSize = MediaQuery.of(context).size;
    final height = _computeHeight(screenSize);
    final double translateQuotient = _computeTranslateQuotient(screenSize);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragUpdate: (DragUpdateDetails details) =>
          _closeOnSwipeDown(context, details),
      child: Container(
        height: height,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(),
        child: Transform.translate(
          offset: Offset(0, height * translateQuotient),
          child: Stack(
            children: [
              Image(
                semanticLabel: 'examination_page',
                width: double.infinity,
                image: AssetImage(
                  'assets/images/body_${bodySide.name.toLowerCase()}.png',
                ),
                alignment: Alignment.topCenter,
                fit: BoxFit.fitWidth,
              ),
              ...examinationPoints
                  .where(
                    (rp) =>
                        rp.point.bodySide == bodySide &&
                        rp.point.spot.organ == organType,
                  )
                  .map(
                    (rp) => RecordPointView(
                      id: rp.id!,
                      offsetX: rp.point.offsetX,
                      offsetY: rp.point.offsetY,
                      records: rp.records,
                      spot: rp.point.spot,
                      nameId: rp.point.name,
                      enabled: _isPointSelectable(rp),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  bool _isPointSelectable(ExaminationPoint point) =>
      mutable || point.records.isNotEmpty;

  double _computeHeight(Size screenSize) {
    return (screenSize.width / Config.examBodyImageBaseWidth) *
        Config.bodyImageBaseHeight;
  }

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
