import 'package:freezed_annotation/freezed_annotation.dart';

import '../../record/entities/record.dart';
import '../../record/entities/record_point.dart';

part 'examination_point.freezed.dart';
part 'examination_point.g.dart';

@freezed
class ExaminationPoint with _$ExaminationPoint {
  const factory ExaminationPoint({
    String? id,
    required RecordPoint point,
    @Default(<Record>[]) List<Record> records,
  }) = _ExaminationPoint;

  factory ExaminationPoint.fromJson(Map<String, dynamic> json) =>
      _$ExaminationPointFromJson(json);
}
