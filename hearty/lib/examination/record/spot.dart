import '../../generated/locale_keys.g.dart';
import 'organ_type.dart';

enum Spot {
  // Heart body spots
  erbs,
  tricuspid,
  apex,
  pulmonary,
  aortic,
  erbsRight,
  rightCarotid,
  leftCarotid,

  // Lung body spots
  middleBackLeftLung,
  middleBackRightLung,
  lowerBackLeftLung,
  lowerBackRightLung,
  upperBackLeftLung,
  upperBackRightLung,
  rightAxillaryLung,
  leftAxillaryLung,
  rightSubclavianLung,
  leftSubclavianLung,
  rightAnteriorLowerLung,
  leftAnteriorLowerLung,
}

extension HeartSpotExtension on Spot {
  static final Map<Spot, String> _map = {
    Spot.apex: LocaleKeys.Apex,
    Spot.tricuspid: LocaleKeys.Tricuspid,
    Spot.aortic: LocaleKeys.Aortic,
    Spot.rightCarotid: LocaleKeys.Right_Carotid,
    Spot.leftCarotid: LocaleKeys.Left_Carotid,
    Spot.erbs: LocaleKeys.Erb_s,
    Spot.pulmonary: LocaleKeys.Pulmonary,
    Spot.erbsRight: LocaleKeys.Erb_s_Right,
    Spot.middleBackLeftLung: LocaleKeys.Middle_Back_Left,
    Spot.middleBackRightLung: LocaleKeys.Middle_Back_Right,
    Spot.lowerBackLeftLung: LocaleKeys.Lower_Back_Left,
    Spot.lowerBackRightLung: LocaleKeys.Lower_Back_Right,
    Spot.upperBackLeftLung: LocaleKeys.Upper_Back_Left,
    Spot.upperBackRightLung: LocaleKeys.Upper_Back_Right,
    Spot.rightAxillaryLung: LocaleKeys.Right_Axillary_Posterior,
    Spot.leftAxillaryLung: LocaleKeys.Left_Axillary_Posterior,
    Spot.rightSubclavianLung: LocaleKeys.Right_Subclavian,
    Spot.leftSubclavianLung: LocaleKeys.Left_Subclavian,
    Spot.rightAnteriorLowerLung: LocaleKeys.Right_Anterior_Lower,
    Spot.leftAnteriorLowerLung: LocaleKeys.Left_Anterior_Lower,
  };

  String get name => _map[this]!;

  static const Map<Spot, int> _nameToNumberMap = {
    // Heart body spots
    Spot.erbs: 1,
    Spot.tricuspid: 2,
    Spot.apex: 3,
    Spot.pulmonary: 4,
    Spot.aortic: 5,
    Spot.erbsRight: 6,
    Spot.leftCarotid: 7,
    Spot.rightCarotid: 8,

    // Lungs body spots
    Spot.leftSubclavianLung: 1,
    Spot.rightSubclavianLung: 2,
    Spot.leftAnteriorLowerLung: 3,
    Spot.rightAnteriorLowerLung: 4,
    Spot.upperBackLeftLung: 5,
    Spot.upperBackRightLung: 6,
    Spot.middleBackLeftLung: 7,
    Spot.middleBackRightLung: 8,
    Spot.lowerBackLeftLung: 9,
    Spot.lowerBackRightLung: 10,
    Spot.leftAxillaryLung: 11,
    Spot.rightAxillaryLung: 12,
  };

  int get number => _nameToNumberMap[this]!;

  static const Map<Spot, String> _nameToDescriptionMap = {
    // Heart body spots
    Spot.erbs: LocaleKeys.Spot_position_erbs,
    Spot.tricuspid: LocaleKeys.Spot_position_tricuspid,
    Spot.apex: LocaleKeys.Spot_position_apex,
    Spot.aortic: LocaleKeys.Spot_position_aortic,
    Spot.rightCarotid: LocaleKeys.Spot_position_rightCarotid,

    // Lungs body spots
    Spot.middleBackLeftLung: LocaleKeys.Spot_position_default,
    Spot.middleBackRightLung: LocaleKeys.Spot_position_default,
    Spot.lowerBackLeftLung: LocaleKeys.Spot_position_default,
    Spot.lowerBackRightLung: LocaleKeys.Spot_position_default,
  };

  String get positionDescription => _nameToDescriptionMap[this]!;

  OrganType get organ => _spotOrganMap[this] ?? OrganType.lungs;

  static const Map<Spot, OrganType> _spotOrganMap = {
    Spot.erbs: OrganType.heart,
    Spot.tricuspid: OrganType.heart,
    Spot.apex: OrganType.heart,
    Spot.pulmonary: OrganType.heart,
    Spot.aortic: OrganType.heart,
    Spot.erbsRight: OrganType.heart,
    Spot.rightCarotid: OrganType.heart,
    Spot.leftCarotid: OrganType.heart,
  };
}
