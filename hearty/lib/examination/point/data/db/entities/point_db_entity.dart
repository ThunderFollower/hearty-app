import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/core.dart';
import '../../../../record/index.dart';
import '../../../point.dart';

part 'point_db_entity.freezed.dart';
part 'point_db_entity.g.dart';

/// A database entity representation of [Point].
///
/// This entity is used to map the [Point] domain model to a structured
/// format suitable for database storage and vice versa.
@freezed
class PointDbEntity with _$PointDbEntity implements Point {
  /// The table name used for storing this entity in the database.
  static String tableName = 'Point';

  const factory PointDbEntity({
    /// Unique identifier of the point (Primary Key).
    required String id,

    /// Represents the location on the body. Serialized as an integer.
    /// Can take values between 0 to 8 inclusive.
    @JsonKey(toJson: _spotToInt, fromJson: _intToSpot) required Spot spot,

    /// Type of point.  Serialized as an integer. Expected values: [0, 1].
    /// Serialized as an integer.
    @JsonKey(toJson: _organTypeToInt, fromJson: _intToOrganType)
    required OrganType type,

    /// Side of the body where the point is located. Serialized as an integer.
    /// Expected values: [0, 1].
    @JsonKey(toJson: _bodySideToInt, fromJson: _intToBodySide)
    required BodySide bodySide,

    /// The X-axis offset position of the point on a graphical representation.
    required double offsetX,

    /// The Y-axis offset position of the point on a graphical representation.
    required double offsetY,

    /// The date and time when this entity is considered expired or no longer
    /// relevant. Serialized as unix timestamp.
    @JsonKey(
      toJson: dateTimeToUnixTimestamp,
      fromJson: unixTimestampToDateTime,
    )
    required DateTime expireAt,
  }) = _PointDbEntity;

  /// Creates a [PointDbEntity] object from a JSON [Map].
  factory PointDbEntity.fromJson(Map<String, dynamic> json) =>
      _$PointDbEntityFromJson(json);
}

int _spotToInt(Spot spot) => spot.index;
Spot _intToSpot(int index) => Spot.values[index];

int _organTypeToInt(OrganType organ) => organ.index;
OrganType _intToOrganType(int index) => OrganType.values[index];

int _bodySideToInt(BodySide bodySide) => bodySide.index;
BodySide _intToBodySide(int index) => BodySide.values[index];
