import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/core.dart';
import '../../asset/index.dart';
import '../body_side.dart';
import '../record_analysis_status.dart';
import '../spot.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record implements Serializable<Record> {
  const factory Record({
    @JsonKey(includeIfNull: false) String? id,
    @JsonKey(name: 'examination_point_id') String? examinationPointId,
    @JsonKey(name: 'body_position') required BodyPosition bodyPosition,
    @JsonKey(includeIfNull: false) Asset? asset,
    @JsonKey(name: 'asset_id') String? assetId,
    @JsonKey(name: 'analysis', includeIfNull: false)
    RecordAnalysisStatus? analysisStatus,
    @JsonKey(fromJson: _legacySpotStringToSpot) Spot? spot,
    @JsonKey(name: 'examination_id') String? examinationId,
  }) = _Record;

  const Record._();

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  bool get isNew => id == null;
}

/// Converts legacy spots to the new spot enumeration.
/// If the value matches with one of the new spots, it returns null.
/// Otherwise, it maps legacy spots to their corresponding new spots.
Spot? _legacySpotStringToSpot(String? value) {
  if (value != null && Spot.values.asNameMap().containsKey(value)) {
    return Spot.values.byName(value);
  }
  return null;
}
