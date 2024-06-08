import '../../../../../../core/core.dart';
import '../../../../../examination.dart';

class CreateExaminationDto implements Serializable<Json> {
  final Examination prototype;

  const CreateExaminationDto(this.prototype);

  @override
  Json toJson() => prototype.getCreateJson;
}
