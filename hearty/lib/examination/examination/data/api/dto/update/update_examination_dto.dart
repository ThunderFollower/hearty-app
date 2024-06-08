import '../../../../../../core/core.dart';
import '../../../../../examination.dart';

class UpdateExaminationDto implements Serializable<Json> {
  final Examination examination;

  const UpdateExaminationDto(this.examination);

  @override
  Json toJson() => examination.toJson();
}
