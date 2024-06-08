import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../record/index.dart';
import 'detail/predefined_examination_points.dart';
import 'examination_diseases.dart';
import 'examination_point.dart';

part 'examination.freezed.dart';
part 'examination.g.dart';

const examPointsName = 'examination_points';
const predefinedPoints = PredefinedExaminationPoints.examinationPoints;

@freezed
class Examination with _$Examination {
  const factory Examination({
    String? id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'modified_at') DateTime? modifiedAt,
    @Default(PredefinedExaminationPoints.examinationPoints)
    @JsonKey(
      name: examPointsName,
      fromJson: legacyExaminationPointsFromJson,
    )
    List<ExaminationPoint> examinationPoints,
    @JsonKey(name: 'notes') @Default(null) String? notes,
    int? age,
    int? weight,
    @JsonKey(name: 'diseases')
    @Default(ExaminationDiseases())
    ExaminationDiseases diseases,
    String? from,
  }) = _Examination;

  const Examination._();

  factory Examination.fromJson(Map<String, dynamic> json) =>
      _$ExaminationFromJson(json);

  String get date => DateFormat.yMMMM().add_jm().format(createdAt);

  bool get isNew => id == null;

  Map<String, dynamic> get getCreateJson {
    final json = toJson();
    final examPoints = json.remove(examPointsName) as List<dynamic>;
    json['record_points'] = examPoints.map((e) {
      final point =
          (e as Map<String, dynamic>)['point'] as Map<String, dynamic>;
      point.remove('id');
      return point;
    }).toList();
    json.remove('id');
    return json;
  }

  bool get hasAdditionalInfo =>
      notes != null || diseases.hasHeartDiseases || diseases.hasLungDiseases;
}

/// Converts an array of `ExaminationPoint` with legacy spots to a list of `ExaminationPoint`.
/// If the input array is null or an error occurs during the conversion,
/// it returns the predefined examination points.
List<ExaminationPoint> legacyExaminationPointsFromJson(
  List<dynamic>? jsonArray,
) {
  final response = jsonArray
          ?.map((e) {
            try {
              return ExaminationPoint.fromJson(e as Map<String, dynamic>);
            } catch (error, stackTrace) {
              final logger = Logger();
              logger.e('ExaminationPoint parsing error.', error, stackTrace);
              return null;
            }
          })
          .where((element) => element != null)
          .map((e) => e!) // direct cast after ensuring non-null
          .toList() ??
      [];

  final spotNames = response.map((examPoint) => examPoint.point.name);

  response.addAll(
    predefinedPoints.where((point) => !spotNames.contains(point.point.name)),
  );

  final nameToRecordPointMap = Map.fromEntries(
    predefinedPoints.map((point) => MapEntry(point.point.name, point.point)),
  );

  _updatePointsCoordinates(response, nameToRecordPointMap);

  return response;
}

// The coordinates should correspond to hardcoded values.
void _updatePointsCoordinates(
  List<ExaminationPoint> response,
  Map<String, RecordPoint> spotPositions,
) {
  for (final examPoint in response) {
    final spotName = examPoint.point.name;
    final position = spotPositions[spotName];

    if (position != null) {
      final updatedPoint = examPoint.copyWith(
        point: examPoint.point.copyWith(
          offsetX: position.offsetX,
          offsetY: position.offsetY,
        ),
      );
      final index = response.indexOf(examPoint);
      response[index] = updatedPoint;
    }
  }
}
