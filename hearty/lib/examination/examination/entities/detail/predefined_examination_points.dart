import '../../../record/index.dart';
import '../examination_point.dart';

class PredefinedExaminationPoints {
  PredefinedExaminationPoints._();

  static const examinationPoints = [
    ExaminationPoint(
      id: 'h1',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.erbs,
        offsetY: 0.675,
        offsetX: 0.485,
      ),
    ),

    ExaminationPoint(
      id: 'h2',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.tricuspid,
        offsetY: 0.77,
        offsetX: 0.485,
      ),
    ),

    ExaminationPoint(
      id: 'h3',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.apex,
        offsetY: 0.87,
        offsetX: 0.65,
      ),
    ),

    ExaminationPoint(
      id: 'h4',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.pulmonary,
        offsetY: 0.58,
        offsetX: 0.485,
      ),
    ),

    ExaminationPoint(
      id: 'h5',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.aortic,
        offsetY: 0.58,
        offsetX: 0.355,
      ),
    ),

    ExaminationPoint(
      id: 'h6',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.erbsRight,
        offsetY: 0.675,
        offsetX: 0.355,
      ),
    ),

    ExaminationPoint(
      id: 'h7',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.rightCarotid,
        offsetY: 0.40,
        offsetX: 0.355,
      ),
    ),

    ExaminationPoint(
      id: 'h8',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.leftCarotid,
        offsetY: 0.40,
        offsetX: 0.485,
      ),
    ),

    // LUNGS
    ExaminationPoint(
      id: 'l1',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.upperBackLeftLung,
        offsetY: 0.46,
        offsetX: 0.29,
      ),
    ),
    ExaminationPoint(
      id: 'l2',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.upperBackRightLung,
        offsetY: 0.46,
        offsetX: 0.54,
      ),
    ),
    ExaminationPoint(
      id: 'l3',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.middleBackLeftLung,
        offsetY: 0.635,
        offsetX: 0.32,
      ),
    ),
    ExaminationPoint(
      id: 'l4',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.middleBackRightLung,
        offsetY: 0.635,
        offsetX: 0.51,
      ),
    ),
    ExaminationPoint(
      id: 'l5',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.lowerBackLeftLung,
        offsetY: 0.81,
        offsetX: 0.29,
      ),
    ),
    ExaminationPoint(
      id: 'l6',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.lowerBackRightLung,
        offsetY: 0.81,
        offsetX: 0.54,
      ),
    ),
    ExaminationPoint(
      id: 'l7',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.leftAxillaryLung,
        offsetY: 0.83,
        offsetX: 0.14,
      ),
    ),
    ExaminationPoint(
      id: 'l8',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.rightAxillaryLung,
        offsetY: 0.83,
        offsetX: 0.69,
      ),
    ),
    ExaminationPoint(
      id: 'l9',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.rightSubclavianLung,
        offsetY: 0.58,
        offsetX: 0.28,
      ),
    ),
    ExaminationPoint(
      id: 'l10',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.leftSubclavianLung,
        offsetY: 0.58,
        offsetX: 0.55,
      ),
    ),
    ExaminationPoint(
      id: 'l11',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.rightAnteriorLowerLung,
        offsetY: 0.79,
        offsetX: 0.16,
      ),
    ),
    ExaminationPoint(
      id: 'l12',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.leftAnteriorLowerLung,
        offsetY: 0.79,
        offsetX: 0.67,
      ),
    ),
  ];

  static const stethoscopeBodyExaminationPoints = [
    // HEART
    ExaminationPoint(
      id: 'h1',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.erbs,
        offsetY: 0.53,
        offsetX: 0.52,
      ),
    ),
    ExaminationPoint(
      id: 'h2',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.tricuspid,
        offsetY: 0.61,
        offsetX: 0.52,
      ),
    ),
    ExaminationPoint(
      id: 'h3',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.apex,
        offsetY: 0.67,
        offsetX: 0.64,
      ),
    ),
    ExaminationPoint(
      id: 'h4',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.pulmonary,
        offsetY: 0.45,
        offsetX: 0.52,
      ),
    ),
    ExaminationPoint(
      id: 'h5',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.aortic,
        offsetY: 0.45,
        offsetX: 0.445,
      ),
    ),
    ExaminationPoint(
      id: 'h6',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.erbsRight,
        offsetY: 0.53,
        offsetX: 0.445,
      ),
    ),
    ExaminationPoint(
      id: 'h7',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.rightCarotid,
        offsetY: 0.31,
        offsetX: 0.445,
      ),
    ),
    ExaminationPoint(
      id: 'h8',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.heart,
        spot: Spot.leftCarotid,
        offsetY: 0.31,
        offsetX: 0.52,
      ),
    ),

    // LUNGS
    ExaminationPoint(
      id: 'l1',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.upperBackLeftLung,
        offsetY: 0.38,
        offsetX: 0.355,
      ),
    ),
    ExaminationPoint(
      id: 'l2',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.upperBackRightLung,
        offsetY: 0.38,
        offsetX: 0.595,
      ),
    ),
    ExaminationPoint(
      id: 'l3',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.middleBackLeftLung,
        offsetY: 0.5025,
        offsetX: 0.38,
      ),
    ),
    ExaminationPoint(
      id: 'l4',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.middleBackRightLung,
        offsetY: 0.5025,
        offsetX: 0.575,
      ),
    ),
    ExaminationPoint(
      id: 'l5',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.lowerBackLeftLung,
        offsetY: 0.625,
        offsetX: 0.355,
      ),
    ),
    ExaminationPoint(
      id: 'l6',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.lowerBackRightLung,
        offsetY: 0.625,
        offsetX: 0.595,
      ),
    ),
    ExaminationPoint(
      id: 'l7',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.leftAxillaryLung,
        offsetY: 0.64,
        offsetX: 0.28,
      ),
    ),
    ExaminationPoint(
      id: 'l8',
      point: RecordPoint(
        bodySide: BodySide.back,
        type: OrganType.lungs,
        spot: Spot.rightAxillaryLung,
        offsetY: 0.64,
        offsetX: 0.665,
      ),
    ),
    ExaminationPoint(
      id: 'l9',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.rightSubclavianLung,
        offsetY: 0.47,
        offsetX: 0.36,
      ),
    ),
    ExaminationPoint(
      id: 'l10',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.leftSubclavianLung,
        offsetY: 0.47,
        offsetX: 0.58,
      ),
    ),
    ExaminationPoint(
      id: 'l11',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.rightAnteriorLowerLung,
        offsetY: 0.61,
        offsetX: 0.28,
      ),
    ),
    ExaminationPoint(
      id: 'l12',
      point: RecordPoint(
        bodySide: BodySide.front,
        type: OrganType.lungs,
        spot: Spot.leftAnteriorLowerLung,
        offsetY: 0.61,
        offsetX: 0.66,
      ),
    ),
  ];
}
