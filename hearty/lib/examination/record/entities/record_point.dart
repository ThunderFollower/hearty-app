import 'package:freezed_annotation/freezed_annotation.dart';

import '../body_side.dart';
import '../organ_type.dart';
import '../spot.dart';

part 'record_point.freezed.dart';
part 'record_point.g.dart';

@freezed
class RecordPoint with _$RecordPoint {
  const factory RecordPoint({
    String? id,
    required Spot spot,
    required OrganType type,
    @JsonKey(name: 'body_side') required BodySide bodySide,
    @JsonKey(name: 'offset_x') required double offsetX,
    @JsonKey(name: 'offset_y') required double offsetY,
  }) = _RecordPoint;

  const RecordPoint._();

  factory RecordPoint.fromJson(Map<String, dynamic> json) =>
      _$RecordPointFromJson(json);

  String get name => spot.name;
}
