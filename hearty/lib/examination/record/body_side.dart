import '../../generated/locale_keys.g.dart';

enum BodySide { front, back }

extension BodySideExtension on BodySide {
  String get name =>
      this == BodySide.front ? LocaleKeys.Front : LocaleKeys.Back;

  String get nameReversed =>
      this == BodySide.front ? LocaleKeys.Back : LocaleKeys.Front;
}

enum BodyPosition {
  sitting,
  standing,
  supine,
  leftDecubitus,
  squatting,
}

extension BodyPositionExtension on BodyPosition {
  static final Map<BodyPosition, String> _map = {
    BodyPosition.standing: LocaleKeys.Standing,
    BodyPosition.sitting: LocaleKeys.Sitting,
    BodyPosition.supine: LocaleKeys.Lying_Face_Up,
    BodyPosition.leftDecubitus: LocaleKeys.On_Left_Side,
    BodyPosition.squatting: LocaleKeys.Squatting,
  };

  static final Map<BodyPosition, String> _positionToIconPathMap = {
    BodyPosition.standing: 'assets/images/standing.svg',
    BodyPosition.sitting: 'assets/images/sitting.svg',
    BodyPosition.supine: 'assets/images/lying_face_up.svg',
    BodyPosition.leftDecubitus: 'assets/images/on_left_side.svg',
    BodyPosition.squatting: 'assets/images/squatting.svg',
  };

  static final Map<String, BodyPosition> _reversedMap = Map.fromEntries(
    _map.entries.map((e) => MapEntry(e.value, e.key)).toList().reversed,
  );

  String get name => _map[this]!;

  String get iconPath => _positionToIconPathMap[this]!;

  BodyPosition getByName(String name) => _reversedMap[name]!;
}
