import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/storage/serializable.dart';
import '../../../../../record/body_side.dart';
import '../../../../../record/organ_type.dart';
import '../../../../../record/spot.dart';
import '../../../../point.dart';

part 'point_response_dto.freezed.dart';
part 'point_response_dto.g.dart';

@freezed
class PointResponseDto
    with _$PointResponseDto
    implements Serializable<PointResponseDto>, Point {
  const factory PointResponseDto({
    required String id,
    required Spot spot,
    required OrganType type,
    @JsonKey(name: 'body_side') required BodySide bodySide,
    @JsonKey(name: 'offset_x') required double offsetX,
    @JsonKey(name: 'offset_y') required double offsetY,
  }) = _PointResponseDto;

  const PointResponseDto._();

  factory PointResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PointResponseDtoFromJson(json);
}
