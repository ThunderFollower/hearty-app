import '../record/body_side.dart';
import '../record/organ_type.dart';
import '../record/spot.dart';

/// Represents the point on the human body.
abstract class Point {
  String get id;

  Spot get spot;

  OrganType get type;

  BodySide get bodySide;

  double get offsetX;

  double get offsetY;
}
