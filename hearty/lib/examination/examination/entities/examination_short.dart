import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../record/index.dart';
import 'examination.dart';

part 'examination_short.freezed.dart';
part 'examination_short.g.dart';

@freezed
class ExaminationShort with _$ExaminationShort {
  const factory ExaminationShort({
    required String id,
    required String title,
    @JsonKey(name: 'modified_at') required DateTime modifiedAt,
    @Default(0) int heart,
    @Default(0) @JsonKey(name: 'lungs') int lung,
    String? from,
  }) = _ExaminationShort;

  const ExaminationShort._();

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExaminationShort &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(id),
      );

  String get date => DateFormat.yMMMd().add_jm().format(modifiedAt.toLocal());

  factory ExaminationShort.fromJson(Map<String, dynamic> json) =>
      _$ExaminationShortFromJson(json);

  factory ExaminationShort.fromExamination(Examination examination) =>
      ExaminationShort(
        id: examination.id!,
        title: examination.title,
        modifiedAt: examination.modifiedAt!,
        heart: _countRecordsByType(examination, OrganType.heart),
        lung: _countRecordsByType(examination, OrganType.lungs),
        from: examination.from,
      );

  static int _countRecordsByType(Examination examination, OrganType type) {
    return examination.examinationPoints
        .where((e) => e.point.type == type)
        .map(
          (e) => e.records
              .map((e) => e.asset != null ? 1 : 0)
              .fold(0, (int a, b) => a + b),
        )
        .fold(0, (a, b) => a + b);
  }
}
