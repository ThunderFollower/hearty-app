import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config.dart';
import '../../examination.dart';
import 'utils/point_utils.dart';

typedef SpotMap = Map<String, Spot>;

class ExaminationState {
  final AsyncValue<Examination> examination;
  final String id;
  final bool isReceived;
  final BodyPosition bodyPosition;
  final BodySide bodySide;
  final OrganType organType;
  final SpotMap spots;

  ExaminationState({
    this.examination = const AsyncLoading(),
    this.id = '',
    this.isReceived = false,
    this.bodyPosition = Config.defaultBodyPosition,
    this.bodySide = Config.defaultBodySide,
    this.organType = Config.defaultOrganType,
    SpotMap? spots,
  }) : spots = spots ?? _defaultSpots;

  ExaminationState copyWith({
    AsyncValue<Examination>? examination,
    String? id,
    bool? isReceived,
    BodyPosition? bodyPosition,
    BodySide? bodySide,
    OrganType? organType,
    Map<String, Spot>? spots,
  }) =>
      ExaminationState(
        examination: examination ?? this.examination,
        id: id ?? this.id,
        isReceived: isReceived ?? this.isReceived,
        bodyPosition: bodyPosition ?? this.bodyPosition,
        bodySide: bodySide ?? this.bodySide,
        organType: organType ?? this.organType,
        spots: spots ?? this.spots,
      );

  Spot get currentSpot => spots[pointKey(organType, bodySide)] ?? _defaultSpot;

  Spot get _defaultSpot => organType == OrganType.heart
      ? Config.defaultHeartSpot
      : Config.defaultLungsFrontSpot;
}

final _defaultSpots = {
  pointKey(OrganType.heart, BodySide.front): Config.defaultHeartSpot,
  pointKey(OrganType.lungs, BodySide.front): Config.defaultLungsFrontSpot,
  pointKey(OrganType.lungs, BodySide.back): Config.defaultLungsBackSpot,
};
